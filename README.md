# Unofficial web app wrapper for Office 365 web apps

A set of web app wrappers, based on QtWebEngine, for the following websites:

- [Outlook](https://outlook.live.com/mail/0/inbox)
- [Word](https://www.office.com/launch/word)
- [Excel](https://www.office.com/launch/excel)
- [PowerPoint](https://www.office.com/launch/powerpoint)
- [OneDrive](https://onedrive.live.com/)
- [OneNote](https://www.onenote.com/notebooks)

These are links to the Office 365 web apps embedded in a minimalist web browser.

This snap is not supported by or endorsed by Microsoft, Inc.

Office 365, OneNote, OneDrive, Outlook, Excel, PowerPoint, and Microsoft are trademarks or registered trademarks of Microsoft, Inc.

## Download

```
snap install unofficial-webapp-office
```

[![Snap](https://snapcraft.io/static/images/badges/en/snap-store-black.svg)](https://snapcraft.io/unofficial-webapp-office)

## Notes

Check "Keep me signed in" to avoid having to sign into each web app individually.

## Screenshot

![Screenshot](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_819,h_614/https://dashboard.snapcraft.io/site_media/appmedia/2019/12/Screenshot_from_2019-12-14_01-27-09.png)

## How This Works

unofficial-webapp-office.launcher is a bash script.

It sets some variables and then calls a desktop launcher app supplied in a helper kit provided by the Snap team for runnin Qt-based apps. Similiar kits exist for GTK-based apps.

Here is the relevant YAML in the snapcraft.yaml file where it is installed into the snap:

'''
parts:
  desktop-qt5:
    source: https://github.com/ubuntu/snapcraft-desktop-helpers.git
    source-subdir: qt
    plugin: make
    make-parameters: ["FLAVOR=qt5"]
'''
This desktop launcher is used to call qmlscene. qmlscene is part of the Qt UI development toolkit. It is used to run mock-ups of QML files, the Qt markup language. There is no separate C++ binary you would expect to see with a full-fledged Qt application. The logic of the app is embedded in JavaScript embedded in the QML.

qmlscene paints us unofficial-webapp-office.qml. This draws a basic window, embeds a web engine in it, handles two variables passed to it: the name of the website and it's URL, and determines whether to open links in a new window (Microsoft-related links) or in your default OS browser (everything else).

### Build Status

![Status](https://github.com/sirredbeard/unofficial-webapp-office/workflows/snapcraft/badge.svg)

### Snapcraft Store Status

[![Snapcraft](https://snapcraft.io/unofficial-webapp-office/badge.svg)](https://snapcraft.io/unofficial-webapp-office)
