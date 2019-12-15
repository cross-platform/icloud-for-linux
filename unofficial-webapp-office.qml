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
    zoomFactor: 1.0

    url: Qt.application.arguments[1]

    onNewViewRequested: function(request) {
      if (request.requestedUrl.toString().includes('live.com')) {
        var newWindow = windowComponent.createObject(windowParent);
        request.openIn(newWindow.webView);
      }
      else if (request.requestedUrl.toString().includes('microsoft.com')) {
        var newWindow = windowComponent.createObject(windowParent);
        request.openIn(newWindow.webView);
      }
      else if (request.requestedUrl.toString().includes('office.com')) {
        var newWindow = windowComponent.createObject(windowParent);
        request.openIn(newWindow.webView);
      }
      else if (request.requestedUrl.toString().includes('office365.com')) {
        var newWindow = windowComponent.createObject(windowParent);
        request.openIn(newWindow.webView);
      }
      else if (request.requestedUrl.toString().includes('outlook.com')) {
        var newWindow = windowComponent.createObject(windowParent);
        request.openIn(newWindow.webView);
      }
      else if (request.requestedUrl.toString().includes('bing.com')) {
        var newWindow = windowComponent.createObject(windowParent);
        request.openIn(newWindow.webView);
      }
      else if (request.requestedUrl.toString().includes('msn.com')) {
        var newWindow = windowComponent.createObject(windowParent);
        request.openIn(newWindow.webView);
      }
      else if (request.requestedUrl.toString().includes('onenote.com')) {
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
