![Header](https://raw.githubusercontent.com/Karetski/Snowonder/master/Resources/ReadmeHeader.png)

**Snowonder** is an import declarations formatter Xcode Extension. It adds ability to sort and clean import declarations block in a current source file. For now it supports only **Swift** and **Objective-C**, but support for other languages is coming soon. This extension is created with latest Swift release and fully open source.

For now Snowonder supports only **Xcode** of version **8 and higher**. If you're looking for **Xcode 7.3** version please check [legacy](https://github.com/Karetski/Snowonder/blob/legacy/README.md) branch.

If you've found some bug, or having some other troubles feel free to submit an issue. This is the simpliest way to make the project better 🌟

[![Build Status](https://travis-ci.org/Karetski/Snowonder.svg)](https://travis-ci.org/Karetski/Snowonder)

## Features [ 🐴 — Current stable, 🦄 — Pre-release ]

#### 2.1
- [ ] Load config from JSON
#### 2.0 🦄
- [ ] Setup key binding from Snowonder wrapper application
- [x] Adding Import Declarations from anywhere in code
#### 1.1 🐴
- [x] Duplicated Import Declarations filtering
#### 1.0
- [x] Import Declarations categorization
- [x] Alphabetical sorting of Import Declarations in scope of category
- [x] Swift and Objective-C programming languages support
- [x] Extension enabling from Snowonder wrapper application

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
