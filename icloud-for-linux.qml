import QtQuick 2.3
import QtQuick.Window 2.3
import QtWebView 1.1

Window {
  title: Qt.application.arguments[2]
  width: 800
  height: 600

  WebView {
    anchors.fill: parent
    url: "https://www.icloud.com/" + Qt.application.arguments[1]
  }
}
