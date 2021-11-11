import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Dialog {
    title: "Settings"

    standardButtons: Dialog.Ok | Dialog.Cancel
    onAccepted: console.log("Ok clicked")
    onRejected: console.log("Cancel clicked")

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        RowLayout {
            id: rowLayout
            Layout.fillHeight: false
            Layout.fillWidth: true
            anchors.fill: parent

            Label {
                id: label1
                text: qsTr("Default Page:")
            }

            TextField {
                id: textField
                text: qsTr("Text Field")
                Layout.fillWidth: true
            }

        }

        RowLayout {
            id: rowLayout2
            width: 100
            height: 100

            Label {
                id: label2
                text: qsTr("Directory to save:")
            }

            TextField {
                id: textField1
                text: qsTr("Text Field")
                Layout.fillWidth: true
            }

            Button {
                id: button1
                text: qsTr("Path")
            }

        }

        Switch {
            id: element
            text: qsTr("Java Script")
        }

        RowLayout {
            id: rowLayout1
            width: 100
            height: 100

            Label {
                id: label
                text: qsTr("Language:")
                horizontalAlignment: Text.AlignHCenter
                transformOrigin: Item.Center
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                renderType: Text.NativeRendering
                Layout.fillWidth: true
            }

            ComboBox {
                id: comboBox
                Layout.fillWidth: true
            }

        }

        RowLayout {
            id: rowLayout3
            width: 100
            height: 100
        }



    }


}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
