import QtQuick 2.9
import QtQuick.Window 2.3
import QtWebEngine 1.5

Window {
  title: Qt.application.arguments[2]
  width: 960
  height: 600
  visible: true

  WebEngineView {
    id: windowParent
    anchors.fill: parent

    url: "https://www.icloud.com/" + Qt.application.arguments[1]

    onNewViewRequested: function(request) {
      var newWindow = windowComponent.createObject(windowParent);
      request.openIn(newWindow.webView);
    }

    profile.onDownloadRequested: function(download) {
      download.accept();
    }
  }

  property Component windowComponent: Window {
    title: Qt.application.arguments[2]
    width: 960
    height: 600
    visible: true

    onClosing: destroy()

    property WebEngineView webView: webView_

    WebEngineView {
      id: webView_
      anchors.fill: parent
    }
  }
}
