import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 1.0
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


    url: Qt.application.arguments[1]

    // This whole section needs to be re-structured into something easier to maintain:
    
    onNewViewRequested: function(request) {
      if (request.requestedUrl.toString().includes('live.com')) {
        var newWindow = windowComponent.createObject(windowParent);
        newWindow.webView.zoomFactor = windowParent.zoomFactor / 0.8;
        request.openIn(newWindow.webView);
      }
      else if (request.requestedUrl.toString().includes('microsoft.com') ||
          request.requestedUrl.toString().includes('1drv.ms') ||
          request.requestedUrl.toString().includes('office.com') ||
          request.requestedUrl.toString().includes('office365.com') ||
          request.requestedUrl.toString().includes('outlook.com') ||
          request.requestedUrl.toString().includes('bing.com') ||
          request.requestedUrl.toString().includes('msn.com') ||
          request.requestedUrl.toString().includes('onenote.com') ||
          request.requestedUrl.toString().includes('sway.office.com') ||
          request.requestedUrl.toString().includes('sharepoint.com')) {
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
      
    }
  }
}
