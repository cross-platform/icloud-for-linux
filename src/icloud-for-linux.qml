import QtQuick 2.9
import QtQuick.Controls 1.0
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

    Action {
        shortcut: "Ctrl+-"
        onTriggered: windowParent.zoomFactor -= 0.1;
    }
    Action {
        shortcut: "Ctrl++"
        onTriggered: windowParent.zoomFactor += 0.1;
    }
    Action {
        shortcut: "Ctrl+="
        onTriggered: windowParent.zoomFactor += 0.1;
    }

    url: "https://www.icloud.com/" + Qt.application.arguments[1]

    onNewViewRequested: function(request) {
      if (request.requestedUrl.toString().startsWith('https://www.icloud.com/')) {
        var newWindow = windowComponent.createObject(windowParent);
        newWindow.webView.zoomFactor = windowParent.zoomFactor / 0.8
        request.openIn(newWindow.webView);
      }
      else {
        Qt.openUrlExternally(request.requestedUrl)
      }
    }

    // Commenting this out for now as it breaks scrolling
    // profile.httpUserAgent: "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:71.0) Gecko/20100101 Firefox/71.0"

    profile.onDownloadRequested: function(download) {
      download.accept();
    }
  }

  property Component windowComponent: Window {
    id: windowComponent_
    title: Qt.application.arguments[2]
    width: 1000
    height: 600
    visible: true

    onClosing: destroy()

    property WebEngineView webView: webView_

    WebEngineView {
      id: webView_
      anchors.fill: parent

      Action {
          shortcut: "Ctrl+-"
          onTriggered: webView_.zoomFactor -= 0.1;
      }
      Action {
          shortcut: "Ctrl++"
          onTriggered: webView_.zoomFactor += 0.1;
      }
      Action {
          shortcut: "Ctrl+="
          onTriggered: webView_.zoomFactor += 0.1;
      }
    
      onWindowCloseRequested: function() {
        windowComponent_.close()
      }
    }
  }
}
