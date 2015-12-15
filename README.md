# yotta_osx_installer
A simpler way to use yotta on OS X

## Installation Instructions
1. Download and run the .dmg file
2. Copy yotta.app to your applications folder
3. run yotta.app, this will open sandboxed virtual environment to run yotta from

## Technical Details
The yotta.app is created using the [Platypus Installer System](http://sveinbjorn.org/platypus/). 

The yotta.app is littel more than 3 directories
* *`prerequisites`* - the things needed to use yotta, (cmake, ninja, arm-none-eabi-gcc)
* *`source`* - the necessary scripting files to make the virtual environment single-click friendly.
* *`workspace`* - This is the python virtual environment. It has been modified to run on localized path variables and to have its path point to the `prerequisites` folder.

## License
Yotta Windows Installer is licensed under Apache-2.0

## Contributions / Pull Requests
All contributions are Apache 2.0. Only submit contributions where you have authored all of the code. If you do this on work time make sure your employer is cool with this.
