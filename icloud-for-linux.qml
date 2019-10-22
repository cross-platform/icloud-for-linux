import QtQuick 2.9
import QtQuick.Window 2.3
import QtWebEngine 1.5

Window {
  title: Qt.application.arguments[2]
  width: 1000
  height: 600
  visible: true

  WebEngineView {
    id: windowParent
    anchors.fill: parent
    zoomFactor: 0.8

    url: "https://www.icloud.com/" + Qt.application.arguments[1]

    onNewViewRequested: function(request) {
      if (request.requestedUrl.toString().startsWith('https://www.icloud.com/')) {
        var newWindow = windowComponent.createObject(windowParent);
        request.openIn(newWindow.webView);
      }
      else {
        Qt.openUrlExternally(request.requestedUrl)
      }
    }

    profile.onDownloadRequested: function(download) {
      download.accept();
    }
  }

  property Component windowComponent: Window {
    title: Qt.application.arguments[2]
    width: 1000
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
