![Alcatraz](https://raw.githubusercontent.com/Karetski/Snowonder/master/Resources/GithubHeader.png)
Snowonder is a import sorter plugin for Xcode 7.3. It sorts import declarations in a way that you want. For now it only supports Objective-C, but Swift and other languages will be added soon. This plugin is created with latest Swift release and fully open source. 

[![Build Status](https://travis-ci.org/Karetski/Snowonder.svg)](https://travis-ci.org/Karetski/Snowonder)

## Install

### Build Project using Xcode

Clone this repository and open Snowonder.xcodeproj.

```bash
$ git clone https://github.com/Karetski/Snowonder.git
$ cd Snowonder
$ open Snowonder.xcodeproj
```

Then build this project and reboot Xcode.

## Usage

After installation you will be able to sort imports on any file using `⌃S` shortcut, or by selecting `Snowonder > Sort File Import` from the `Edit` menu.

![Usage](https://raw.githubusercontent.com/Karetski/Snowonder/master/Resources/UsageMenu.png)

## Uninstall

Open up your terminal and paste this:

```bash
rm -rf ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/Snowonder.xcplugin
```

## License

Released under the MIT License. See [LICENSE.md](https://github.com/Karetski/Snowonder/blob/master/LICENSE.md).