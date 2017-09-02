![Alcatraz](https://raw.githubusercontent.com/Karetski/Snowonder/legacy/Resources/GithubHeaderBig.png)
Snowonder is a import sorter plugin for Xcode 7.3. It sorts import declarations in a way that you want. For now it only supports Objective-C, but Swift and other languages will be added soon. This plugin is created with latest Swift release and fully open source.

## Install

### Using [Alcatraz](https://github.com/alcatraz/Alcatraz) package manager

The best way of installing is by [Alcatraz](https://github.com/alcatraz/Alcatraz) package manager. Install Alcatraz followed by the instruction, restart your Xcode and press `⇧⌘9` or select `Package Manager` from the `Window` menu. You can find `Snowonder` in the list and click the icon on left to install.

![Alcatraz](https://raw.githubusercontent.com/Karetski/Snowonder/legacy/Resources/AlcatrazScreen.png)

### Using install script

Snowonder can be installed by running the following command in the terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/Karetski/Snowonder/legacy/Scripts/install.sh | sh
```

### Build Project using Xcode

Clone this repository and open Snowonder.xcodeproj.

```bash
git clone https://github.com/Karetski/Snowonder.git
git checkout legacy
cd Snowonder
open Snowonder.xcodeproj
```

Then build this project and reboot Xcode.

## Usage

After installation you will be able to sort imports on any file using `⌃S` shortcut, or by selecting `Snowonder > Sort File Import` from the `Edit` menu.

![Usage](https://raw.githubusercontent.com/Karetski/Snowonder/legacy/Resources/UsageMenu.png)

## Uninstall

Open up your terminal and paste this:

```bash
rm -rf ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/Snowonder.xcplugin
```

## License

Released under the MIT License. See [LICENSE.md](https://github.com/Karetski/Snowonder/blob/legacy/LICENSE.md).
