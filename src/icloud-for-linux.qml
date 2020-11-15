import QtQuick 2.9
import QtQuick.Controls 1.0
import QtQuick.Window 2.3
import QtWebEngine 1.5

Window {
  title: "iCloud " + Qt.application.arguments[2]
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

    // Hack to get certain pages displaying correctly
    Timer {
        id: refreshTimer
        interval: 2000; running: true; repeat: true
        onTriggered: function() {
          windowParent.zoomFactor += 0.0000001;
          windowParent.zoomFactor -= 0.0000001;
        }
    }

    onNewViewRequested: function(request) {
      var target = request.requestedUrl.toString();
      if (target.startsWith('https://www.icloud.com/')) {
        var newWindow = windowComponent.createObject(windowParent);
        newWindow.webView.zoomFactor = windowParent.zoomFactor / 0.8
        if (target.startsWith('https://www.icloud.com/keynote') ||
            target.startsWith('https://www.icloud.com/numbers') ||
            target.startsWith('https://www.icloud.com/pages')) {
          newWindow.webView.url = request.requestedUrl
        }
        else {
          request.openIn(newWindow.webView);
        }
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
    title: "iCloud " + Qt.application.arguments[2]
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
