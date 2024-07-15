# iCloud for Linux  [![Snap](https://snapcraft.io/icloud-for-linux/badge.svg)](https://snapcraft.io/icloud-for-linux)

iCloud for Linux enables its users the ability to access iCloud services on a Linux machine. This application uses GTK and WebKit to provide a user interface for various iCloud services.

## Features

- Access iCloud Mail, Contacts, Calendar, Photos, Drive, Notes, Reminders, Pages, Numbers, Keynote, and Find My iPhone
- Supports both X11 and Wayland environments
- Customizable top-level domain (TLD) via environment variable

## Prerequisites

- A Linux distribution (tested on openSUSE Tumbleweed 20240711 x86_64 and Ubuntu 20.04)
- Development tools: `gcc`, `g++`, `cmake`, `make`, `pkg-config`
- Libraries: `gtk+-3.0`, `webkit2gtk+-4.0`

## Building from Source

1. **Install dependencies**:

   On openSUSE:
   ```bash
   sudo zypper install gcc gcc-c++ cmake make pkg-config gtk3-devel webkit2gtk4-devel
   ```
   On Ubuntu:
   ```bash
   sudo apt-get update
   sudo apt-get install -y gcc g++ cmake make pkg-config libgtk-3-dev libwebkit2gtk-4.0-dev
   ```
2. **Clone the repository**:
```bash
git clone --recursive https://github.com/cross-platform/icloud-for-linux.git icloud-for-linux-0.22
cd icloud-for-linux-0.22
```
3. **Build the application**:
```bash
mkdir -p build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make install
```

## Running the Application
To run the application, use the following syntax:
```bash
./icloud-for-linux <page> <title>  # Example: ./nimbus mail "iCloud Mail"
```
  - `<page>`: The iCloud service you want to access
    - `mail`: iCloud Mail
    - `contacts`: iCloud Contacts
    - `calendar`: iCloud Calendar
    - `photos`: iCloud Photos
    - `drive`: iCloud Drive
    - `notes`: iCloud Notes
    - `reminders`: iCloud Reminders
    - `pages`: iCloud Pages
    - `numbers`: iCloud Numbers
    - `keynote`: iCloud Keynote
    - `findmyiphone`: Find My iPhone
  - `<title>`: The window title

## Customizing the Top-Level Domain (TLD)
You can customize the top-level domain (TLD) used in the URLs by setting the `ICLOUD_TLD` environment variable:
```bash
export ICLOUD_TLD=".co.uk"
./nimbus mail "iCloud Mail"
```

## Packaging for RPM

To package iCloud for Linux for openSUSE, you can use the provided `icloud-for-linux.spec` file.

1. **Set up the RPM build environment**:
  ```bash
  sudo zypper install rpmdevtools rpm-build rpmlint
  rpmdev-setuptree
  ```
2. **Copy the source files**:
  ```bash
  mkdir -p ~/rpmbuild/SOURCES
  tar czf ~/rpmbuild/SOURCES/icloud-for-linux-0.22.tar.gz -C ../.. icloud-for-linux-0.22
  cp icloud-for-linux.spec ~/rpmbuild/SPECS/
  ```
3. **Build the RPM package**:
  ```bash
  rpmbuild -ba --verbose ~/rpmbuild/SPECS/icloud-for-linux.spec
  ```

## Contributing

If you would like to contribute to this project, please feel free to fork the repository and submit a pull request.

## Snap Package
[![Snap](https://bit.ly/2ZWfetD)](https://snapcraft.io/icloud-for-linux)
![Screenshot](https://bit.ly/2W5hyxj)
