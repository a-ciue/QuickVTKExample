import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs


ApplicationWindow {
  visible: true
  width: 640
  height: 640
  title: qsTr("Hello World")

  header: ToolBar {
    id: header
    RowLayout {
      anchors.fill: parent
      RowLayout {
        spacing: 1
        Button {
          id: btn1
          text: "Button1"
          rightPadding: 8
        }
        Button {
          id: btn2
          text: "Button2"
        }
        Button {
          id: btn3
          text: "Button3"
        }
        Button {
            id: btn4
            text: qsTr("Choose Model...")
            onClicked: fileDialog.open()
        }
        Component.onCompleted: {
          let width = Math.max(btn1.width, btn2.width, btn3.width, btn4.width)
          btn1.Layout.preferredWidth = width
          btn2.Layout.preferredWidth = width
          btn3.Layout.preferredWidth = width
          btn4.Layout.preferredWidth = width
        }
      }
      Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
      }
      Rectangle {
        color: "black"
        Layout.preferredWidth: 1
        Layout.fillHeight: true
      }
      Text {
        Layout.leftMargin: 10
        text: "vtkSource:"
      }
      ComboBox {
        id: sources
        Layout.fillHeight: true
        Layout.preferredWidth: childrenRect.width
        model: Presenter.sources
      }
    }
  }

  FileDialog {
      id: fileDialog
      currentFolder: StandardPaths.standardLocations(StandardPaths.DesktopLocation)[0]
      nameFilters: ["OBJ File (*.obj)"]
      onAccepted: myItem.readFile(selectedFile)
  }

    Rectangle {
    border {
        id: border
        width: 5;
        color: dsv.focused === item ? "goldenrod" : "steelblue"
    }
    radius: 5
    color: "magenta"
    anchors.fill: parent

    MyVtkItem {
        id: myItem
        anchors.fill: parent
        anchors.margins: border.width
        source: sources.currentText
    }

  }
}
