import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3


Window {
    id: window
    visible: true
    width: 400
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
                Keys.onEnterPressed: {
                    swipeViewWebPages.currentItem.setUrl(text)
                }
            }

            RoundButton {
                id: roundButtonReload
                text: "R"
                onClicked: swipeViewWebPages.currentItem.reload()
            }

            ToolButton {
                id: toolButton
                text: qsTr("Settings")
            }


        }


        SwipeView {
            id: swipeViewWebPages
            interactive: false
            Layout.fillWidth: true
            Layout.fillHeight: true

            Item {
                id: elementAdd
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
                textEditHttpsAdder.text = swipeViewWebPages.currentItem.getUrl()
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
                swipeViewWebPages.insertItem(index, swipeViewWebPages.createItem())
                swipeViewWebPages.setCurrentIndex(index)
            }

            function createItem(){
                var component = Qt.createComponent("DefaultItemWebPage.qml");
                var item = component.createObject(swipeViewWebPages);
                //TODO: check if successful
                return item
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


}



/*##^##
Designer {
    D{i:8;anchors_height:200;anchors_width:200;anchors_x:0;anchors_y:327}D{i:11;anchors_x:"-9";anchors_y:"-8"}
}
##^##*/
