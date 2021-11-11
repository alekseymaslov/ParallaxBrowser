import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Dialog {
    title: "Menu"
    property var webPage: {''}

    standardButtons: Dialog.Ok | Dialog.Cancel
    onAccepted: console.log("Ok clicked")
    onRejected: console.log("Cancel clicked")

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        Switch {
            id: scrollbar
            text: qsTr("Scroll bar in pages")
            onClicked: {
                if(scrollbar.checked) {
                    webPage.setScrollbarStatus(true)
                } else {
                    webPage.setScrollbarStatus(false)
                }
            }
        }

        Button {
            id: settings
            text: qsTr("Settings")
            Layout.fillWidth: true
        }

        Button {
            id: addBookmarks
            text: qsTr("Add bookmarks")
            Layout.fillWidth: true
        }


        RowLayout {
            id: rowLayout
            width: 100
            height: 100

            Text {
                id: bookmarks
                text: qsTr("Bookmarks: ")
                font.pixelSize: 21
            }

            ComboBox {
                id: comboBox
                Layout.fillWidth: true
            }

        }

        Switch {
            id: desktopMode
            text: qsTr("Desktop Mode")
            onClicked: {
                if(desktopMode.checked) {
                    webPage.setDesktopMode(1)
                } else {
                    webPage.setDesktopMode(0)
                }
            }
        }

    }

    function setItem(page) {
        if(0 !== page.getDesktopMode()) {
            if(!desktopMode.checked) {
                desktopMode.toggle()
            }
        }
        if(page.getScrollbarStatus()) {
            if(!scrollbar.checked) {
                scrollbar.toggle()
            }
        }

        webPage = page
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1;anchors_height:100;anchors_width:100;anchors_x:75;anchors_y:"-313"}
}
##^##*/
