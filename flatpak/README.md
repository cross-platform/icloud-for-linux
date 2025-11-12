# Flatpak Build Instructions

This directory contains the flatpak manifest for iCloud for Linux.

## Prerequisites

Install flatpak and flatpak-builder:
```bash
sudo apt install flatpak flatpak-builder  # Debian/Ubuntu
sudo dnf install flatpak flatpak-builder  # Fedora
```

Add Flathub repository:
```bash
flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
```

Install the required runtime and SDK:
```bash
flatpak install flathub org.gnome.Platform//49 org.gnome.Sdk//49
```

Install dependency
```bash
sudo apt install libwebkit2gtk-4.0-dev  # Debian/Ubuntu 22
sudo apt install libwebkit2gtk-4.1-dev  # Debian/Ubuntu 24
sudo dnf install webkit2gtk4.0-devel    # Fedora prior 42
sudo dnf install webkit2gtk4.1-devel    # Fedora 42
```

## Building

From the repository root, run:
```bash
flatpak-builder --force-clean build flatpak/io.github.crossplatform.icloud-for-linux.yml
```
If you are building in a development container, you may need to use `--disable-rofiles-fuse`

## Installing Locally

After building, install the flatpak locally:
```bash
flatpak-builder --user --install --force-clean build flatpak/io.github.crossplatform.icloud-for-linux.yml
```

## Running

After installation, you can launch the applications from your application menu, or via command line:
```bash
flatpak run io.github.crossplatform.icloud-for-linux
```

The flatpak installs multiple desktop entries for each iCloud service:
- iCloud Mail
- iCloud Contacts
- iCloud Calendar
- iCloud Photos
- iCloud Drive
- iCloud Notes
- iCloud Reminders
- iCloud Pages
- iCloud Numbers
- iCloud Keynote
- iCloud Find

## Uninstalling

```bash
flatpak uninstall io.github.crossplatform.icloud-for-linux
```

## Publishing to Flathub

To publish this application to Flathub:

1. Fork the [Flathub repository](https://github.com/flathub/flathub)
2. Submit the manifest as a pull request
3. Follow the [Flathub submission guidelines](https://docs.flathub.org/docs/for-app-authors/submission)
