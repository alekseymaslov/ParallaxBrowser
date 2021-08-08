import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtWebEngine 1.4

Item {
    id: elementN
    Frame {
        id: frameForWebPage
        x: 0
        y: 0
        anchors.fill: parent
        Layout.fillHeight: true
        Layout.fillWidth: true

        Page {
            id: pageWebView
            anchors.bottomMargin: -19
            anchors.topMargin: -12
            anchors.leftMargin: -12
            anchors.rightMargin: -12
            anchors.fill: parent
             WebEngineView {
                id: webviewMain
                url: "https://www.google.com/"
                anchors.fill: parent
                 profile:  WebEngineProfile{
                    httpUserAgent: "Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1"
                 }

                onLoadingChanged: {
                    if (loadRequest.status ==  WebEngineView.LoadSucceededStatus) {
                        textEditHttpsAdder.text = webviewMain.url
                    }
                }
            }
        }
    }

    function goBack() {
        webviewMain.goBack()
    }

    function goForward() {
        webviewMain.goForward()
    }

    function reload() {
        webviewMain.reload()
    }

    function setUrl(url) {
        webviewMain.url = textEditHttpsAdder.text
        webviewMain.update()
    }

    function getUrl() {
        return webviewMain.url
    }
}
