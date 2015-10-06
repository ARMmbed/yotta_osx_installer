#! /usr/bin/env python
# Copyright 2015 ARM Limited
#
# Licensed under the Apache License, Version 2.0
# See LICENSE file for details.

import subprocess
import argparse
import json
import sys
import os
import threading

class RunWithTimeout(threading.Thread):
    def __init__(self, command):
        self.command = command
        threading.Thread.__init__(self)

    def run(self):
        self.process = subprocess.Popen(self.command)
        self.process.wait()

    def runFor(self, timeout):
        self.start()
        self.join(timeout)
        if self.is_alive():
            self.process.kill()
            self.join()
            return -1
        else:
            return self.process.returncode

def run():
    p = argparse.ArgumentParser()
    p.add_argument('-t', '--target', dest='target', help='execution target name (e.g. K64F)')
    p.add_argument('-i', '--timeout', dest='timeout', help='max time to wait for the program (seconds)', type=float, default=15.0)
    p.add_argument('program', help='executable file to run')

    args = p.parse_args()

    # run mbed-ls to find a board that matches the specified target:
    mbedls = subprocess.Popen(
        ['mbedls', '--json'],
        stdout=subprocess.PIPE, stderr=subprocess.PIPE
    )
    out, err = mbedls.communicate()
    if mbedls.returncode:
        sys.stderr.write('Failed to list mbeds: %s, %s' % (out, err))
        sys.exit(-1)

    mbeds = json.loads(out)

    serial_port = None
    mount_point = None
    for mbed in mbeds:
        if mbed['platform_name'] == args.target:
            mount_point = mbed['mount_point']
            serial_port = mbed['serial_port']
            break

    if not mount_point:
        sys.stderr.write(
            'Target "%s" not found. Available targets are: %s' %
            (args.target, ', '.join([x['platform_name'] for x in mbeds]))
        )
        sys.exit(-1)
    
    binfile_name = args.program + '.bin'
    # convert the executable to a .bin file, which the mbed test runner needs,
    # if we don't already have one:
    if not os.path.isfile(binfile_name):
        objcopy = subprocess.Popen(
            ['arm-none-eabi-objcopy', '-O', 'binary', args.program, binfile_name],
            stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )
        out, err = objcopy.communicate()
        if objcopy.returncode:
            sys.stderr.write('Failed to generate bin file for executable: %s, %s' % (out, err))
            sys.exit(-1)

    # run mbedhtrun and pipe its output to our stdout & stderr
    returncode = RunWithTimeout([
        'mbedhtrun', '-d', mount_point, '-f', binfile_name, '-p', serial_port, '-C', '4', '-m', args.target
    ]).runFor(args.timeout)
    if returncode:
        sys.exit(returncode)

if __name__ == '__main__':
    run()

