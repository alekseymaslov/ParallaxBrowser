import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2


Window {
    id: window
    visible: true
    width: 500
    height: 600
    title: qsTr("Parallax")

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent


        RowLayout {
            id: rowLayout
            width: 100
            height: 100

            TextField {
                id: textEditHttpsAdder
                width: 80
                height: 20
                text: qsTr("https://www.google.com/")
                Layout.maximumHeight: 27
                placeholderText: qsTr("")
                font.preferShaping: true
                font.kerning: true
                Layout.preferredHeight: -1
                layer.textureMirroring: ShaderEffectSource.MirrorHorizontally
                antialiasing: false
                transformOrigin: Item.TopLeft
                layer.wrapMode: ShaderEffectSource.RepeatHorizontally
                Layout.fillHeight: false
                Layout.rowSpan: 1
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                selectByMouse: true
                persistentSelection: false
                cursorVisible: true
                Layout.fillWidth: true
                font.pixelSize: 12

                function performSearch() {
                    swipeViewWebPages.currentItem.setUrl("https://www.google.com/search?q=" + text)
                }

                onFocusChanged:{
                   if(focus) {
                        selectAll()
                   }
                }

                Keys.onEnterPressed: {
                    performSearch()
                }

                Keys.onReturnPressed: {
                    performSearch()
                }
            }

            RoundButton {
                id: roundButtonReload
                text: "R"
                onClicked: {
                    swipeViewWebPages.currentItem.reload()
                }
            }

            ToolButton {
                id: toolMenu
                text: qsTr("Menu")
                onClicked: {
                    var component = Qt.createComponent("Menu.qml");
                    var item = component.createObject(window);
                    item.height = window.height - 10
                    item.width = window.width - 10
                    item.setItem(swipeViewWebPages.currentItem)
                    item.open()
                }
            }
        }

        SwipeView {
            id: swipeViewWebPages
            objectName: "swipeViewWebPages"

            interactive: false
            Layout.fillWidth: true
            Layout.fillHeight: true

            property var perviousItem: "undefined"

            Item {
                id: elementAdd
                objectName: "elementAdd"
                x: -9
                y: -8

                RoundButton {
                    id: roundButtonNewPage
                    text: "+"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: {
                        swipeViewWebPages.addPage()
                    }
                }
            }


            onCurrentItemChanged: {
                onShowRemovePage()
                if (currentItem != elementAdd) {
                    textEditHttpsAdder.text = currentItem.getUrl().toString()
                    currentItem.setEnable()
                    if(perviousItem !== "undefined") {
                        perviousItem.setDisable()
                    }
                    perviousItem = currentItem

                }
            }

            onCountChanged:  {
                onShowRemovePage()
            }

            function onShowRemovePage() {
                if (currentItem == elementAdd) {
                    roundButtonRemovePage.visible = false
                    roundButtonRemovePage.enabled = false
                }
                else if (buttonPages.down) {
                    roundButtonRemovePage.visible = true
                    roundButtonRemovePage.enabled = true
                }
            }

            function addPage(page) {
                var index = swipeViewWebPages.currentIndex
                var item = swipeViewWebPages.createItem()
                swipeViewWebPages.insertItem(index, item)
                swipeViewWebPages.setCurrentIndex(index)
                item.setMainWindow(window)
                if(page) {
                    item.setUrl(page)
                }
            }

            function createItem() {
                var component = Qt.createComponent("DefaultItemWebPage.qml");
                var item = component.createObject(swipeViewWebPages);
                //TODO: check if successful
                return item
            }

            function getPagesUrls(pageNumber) {
                var page = swipeViewWebPages.itemAt(pageNumber)
                if (currentItem != elementAdd) {
                    return page.getUrl()
                }
                return ""
            }

            function getPageCount() {
                return swipeViewWebPages.count - 1
            }

            function setForcePageActive(force : bool) {
                swipeViewWebPages.currentItem.setForceActive(force);
            }
        }

        PageIndicator {
            id: pageIndicator
            visible: false
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            count: swipeViewWebPages.count
            currentIndex: swipeViewWebPages.currentIndex
        }

        Frame {
            id: frame
            width: 200
            height: 200
            Layout.preferredHeight: -1
            Layout.fillWidth: true

            RowLayout {
                id: rowLayout1
                anchors.fill: parent

                Button {
                    id: buttonBack
                    text: qsTr("<-")
                    onClicked: swipeViewWebPages.currentItem.goBack();
                }

                Button {
                    id: buttonPages
                    text: qsTr("Pages")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onClicked: {
                        buttonPages.down = !buttonPages.down
                        pageIndicator.visible = !pageIndicator.visible
                        swipeViewWebPages.interactive = !swipeViewWebPages.interactive
                        if(!buttonPages.down) {
                            roundButtonRemovePage.visible = false
                            roundButtonRemovePage.enabled = false
                        } else
                        {
                            swipeViewWebPages.onShowRemovePage()
                        }
                    }
                }

                Button {
                    id: buttonForward
                    text: qsTr("->")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    onClicked: swipeViewWebPages.currentItem.goForward()
                }
            }
        }
    }

    RoundButton {
        id: roundButtonRemovePage
        x: 288
        y: 196
        text: "-"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        visible: false
        enabled: false
        onClicked: {
            if (swipeViewWebPages.currentItem !== swipeViewWebPages.elementAdd) {
                swipeViewWebPages.removeItem(swipeViewWebPages.currentItem)
            }
        }
    }

    function hideControls() {
        rowLayout.visible = false
        frame.visible = false
    }

    function showControls() {
        rowLayout.visible = true
        frame.visible = true
    }

    function exposeNotification(notification) {
        console.log("message received tag:" + notification.tag)

        onNotificationRecived(notification.title, notification.message)
    }

    signal onNotificationRecived(title: string, msg: string)
}



/*##^##
Designer {
    D{i:8;anchors_height:200;anchors_width:200;anchors_x:0;anchors_y:327}D{i:11;anchors_x:"-9";anchors_y:"-8"}
}
##^##*/
