import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtWebEngine 1.10


Item {
    id: elementN

    Frame {
        id: frameForWebPage
        x: 0
        y: 0
        height: 500
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

            /*
            WebEngineProfile {
                id: desktopProfile
            }

            WebEngineProfile {
                id: defaultProfile
            }
            */
            Dialog {
                id: askPermission
                title: ""
                standardButtons: Dialog.Yes | Dialog.No
                property var feature: 0
                property var securityOrigin: ""
                onAccepted: function() {
                    if(WebEngineView.Notifications === feature) {
                        webviewMain.notoficationAllow = true
                    }
                    else if(WebEngineView.Geolocation === feature) {
                        webviewMain.geoloacationAllow = true
                    }
                    webviewMain.grantFeaturePermission(securityOrigin, feature, true);
                }
            }

            WebEngineView {
               id: webviewMain
               objectName: "webviewMain"
               url: defaultUrl
               anchors.fill: parent
               settings.defaultTextEncoding: "utf-16"
               settings.focusOnNavigationEnabled: false

               property var defaultUrl: "https://www.google.com/"
               property var mainWindow: ({})
               property var stayWakeup: false
               property var notoficationAllow: false
               property var geoloacationAllow: false
               property var is_desktop: 0

               profile.httpUserAgent: "Mozilla/5.0 (Linux; Android 11; Pixel 4 XL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.105 Mobile Safari/537.36"

               settings.showScrollBars: false


               onLoadingChanged: {
                    if (loadRequest.status ==  WebEngineView.LoadSucceededStatus) {
                        textEditHttpsAdder.text = webviewMain.url
                     }
                    //defaultProfile = webviewMain.profile
                    //desktopProfile = webviewMain.profile
                    //desktopProfile.httpUserAgent = ""
                }

                onFullScreenRequested: function(request) {
                    if (request.toggleOn) {
                         window.showFullScreen()
                         mainWindow.hideControls()
                         console.log("onFullScreenRequested is set")
                    }
                    else {
                         window.showNormal()
                         mainWindow.showControls()
                         console.log("onFullScreenRequested is unset")
                    }
                    request.accept();
                }

                profile.onPresentNotification: function(notification) {
                    console.log("Get message: " + notification.message)
                    mainWindow.exposeNotification(notification)
                }

                onFeaturePermissionRequested: function(securityOrigin, feature) {
                    console.log("This site ask about " + feature);
                    if(WebEngineView.Notifications === feature) {
                        if(!notoficationAllow) {
                            askPermission.feature = feature
                            askPermission.securityOrigin = securityOrigin
                            askPermission.title = "This site request\n push up notification permission."
                            askPermission.open()
                        } else {
                            webviewMain.grantFeaturePermission(securityOrigin, feature, true);
                        }

                    } else if (WebEngineView.Geolocation === feature) {
                        if(!geoloacationAllow) {
                            askPermission.feature = feature
                            askPermission.securityOrigin = securityOrigin
                            askPermission.title = "This site request\n push up geolocation permission."
                            askPermission.open()
                        } else {
                            webviewMain.grantFeaturePermission(securityOrigin, feature, true);
                        }
                    }
                }
            }
        }
    }

    function booleanToString(flag: bool) {
        return flag ? "true" : "false"
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
        webviewMain.url = url
        webviewMain.update()
    }

    function getUrl() {
        return webviewMain.url
    }

    function setMetaData(metadata: string) {
        var jsonObject = JSON.parse(metadata)
        var pageStruct = jsonObject.PageStruct
        webviewMain.url = pageStruct[0]['url']
        webviewMain.stayWakeup = pageStruct[0]['stayWakeup']
        webviewMain.notoficationAllow = pageStruct[0]['notoficationAllow']
        webviewMain.geoloacationAllow = pageStruct[0]['geoloacationAllow']
    }

    function getMetaData() : string {
        var jsonString = '{"PageStruct":[{"url": "%1" }, {"stayWakeup": %2},
                          {"notoficationAllow": %3}, {"geoloacationAllow": %4}]}'
        jsonString = jsonString.arg(webviewMain.url).
            arg(booleanToString(webviewMain.stayWakeup)).
            arg(booleanToString(webviewMain.notoficationAllow)).
            arg(booleanToString(webviewMain.geoloacationAllow))

        console.log(jsonString)
        console.log(webviewMain.notoficationAllow)
        return jsonString
    }

    function setMainWindow(mainWindow) {
       webviewMain.mainWindow = mainWindow
    }

    function getDesktopMode() {
        console.log("getDesktopMode")
        return webviewMain.is_desktop;
    }

    function setDesktopMode(mode) {
        console.log("setDesktopMode:" + mode)
        webviewMain.is_desktop = mode
        if(0 !== mode) {
            //webviewMain.profile = desktopProfile
        } else {
             //webviewMain.profile = defaultProfile
        }
        //reload()
    }

    function setDisable() {
        console.log("setDisable url: " + webviewMain.url)
        if(!webviewMain.stayWakeup) {
            webviewMain.visible = false
            webviewMain.lifecycleState = WebEngineView.LifecycleState.Frozen;
        }
    }

    function setEnable() {
         console.log("setEnable url: " + webviewMain.url)
         webviewMain.visible = true
         webviewMain.lifecycleState = webviewMain.recommendedState
    }

     function setForceActive(force : bool) {
        if(force) {
            webviewMain.lifecycleState =  WebEngineView.LifecycleState.Active;
        }
        else {
             webviewMain.lifecycleState = webviewMain.recommendedState
        }
     }

    function getScrollbarStatus() {
        return webviewMain.settings.showScrollBars
    }

    function setScrollbarStatus(flag) {
       console.log("setScrollbarStatus : " + flag)
        webviewMain.settings.showScrollBars = flag
    }

    function getStayWakeup() {return webviewMain.stayWakeup}
    function setStayWakeup(flag: bool) {webviewMain.stayWakeup = flag}
    function getNotoficationAllow() {return webviewMain.notoficationAllow}
    function setNotoficationAllow(flag: bool) { webviewMain.notoficationAllow = flag}
    function getGeoloacationAllow() {return webviewMain.geoloacationAllow}
    function setGeoloacationAllow(flag: bool) {webviewMain.geoloacationAllow = flag}
    function onCacheClear() {
        console.log("cachePath: " + webviewMain.profile.cachePath)
        webviewMain.profile.clearHttpCache()
        webviewMain.reload()
        var cookiePolicy =  webviewMain.profile.persistentCookiesPolicy
        webviewMain.profile.persistentCookiesPolicy = WebEngineProfile.NoPersistentCookies
        webviewMain.profile.persistentCookiesPolicy = cookiePolicy
    }
}


/*
 webviewMain.runJavaScript('document.addEventListener("keydown", function(e) {
           alert(e.keyCode);
      });
 ');*/

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
