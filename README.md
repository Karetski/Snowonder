![Header](https://raw.githubusercontent.com/Karetski/Snowonder/master/Resources/ReadmeHeader.png)

**Snowonder** is Xcode Extension that adds some convenient formatting operations for Import Declarations. This extension is created with latest stable Swift release and fully open source. Snowonder is based on official Apple's **XcodeKit** which supports only **Xcode** of versions **8 and higher**. If you're looking for a Snowonder that is compatible with **Xcode 7.3** version please check [legacy](https://github.com/Karetski/Snowonder/blob/legacy/README.md) branch.

**Important!** 🌟 If you've experienced some trouble using Snowonder, please submit an issue with a description. This is the simpliest way to make the project better.

[![Build Status](https://travis-ci.org/Karetski/Snowonder.svg)](https://travis-ci.org/Karetski/Snowonder)

## Features

- [x] Adding Import Declarations from anywhere in code
- [x] Import Declarations categorization
- [x] Alphabetical sorting of Import Declarations in scope of category
- [x] Duplicated Import Declarations filtering
- [x] Configurations loading from JSON
- [x] Configurations for both **Swift** and **Objective-C** programming languages included out of the box.
- [ ] Command Line Interface (CLI)

## Installation

1. Close Xcode if it's currently running
2. Download the [**latest release**](https://github.com/Karetski/Snowonder/releases)
3. Put **Snowonder.app** into **Applications** folder and run it
4. Click **Enable Extension** button
5. Enable **Snowonder** in opened window. *See screenshot below*
![Enables](https://raw.githubusercontent.com/Karetski/Snowonder/master/Resources/SnowonderEnabled.png)
6. Launch Xcode and check if <kbd>Editor</kbd> > <kbd>Snowonder Extension</kbd> is available

## Usage

After installation you will be able to format import declarations on any file by selecting <kbd>Editor</kbd> > <kbd>Snowonder Extension</kbd> > <kbd>Format Import Declarations</kbd> or you can just simply setup shoutcut for this command.

## Updating

To update Snowonder just replace the old **Snowonder.app** with updated verson.

## Uninstallation

To uninstall just put **Snowonder.app** into **Trash**.

## License

Released under the MIT License. See [LICENSE.md](https://github.com/Karetski/Snowonder/blob/master/LICENSE.md).
