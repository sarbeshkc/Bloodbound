// LoginPage.qml
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    id: loginPage

    Rectangle {
        anchors.fill: parent
        color: "#F0F0F0"
    }

    Item {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.1
        width: parent.width * 0.8
        height: welcomeText.height

        Text {
            id: welcomeText
            anchors.centerIn: parent
            text: qsTr("Welcome to Bloodbound")
            font.pixelSize: 48
            font.family: "Arial"
            font.weight: Font.Bold
            color: "#333333"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        width: 300

        Button {
            text: "User Login"
            Layout.fillWidth: true
            font.pixelSize: 18
            onClicked: stackView.push("UserLoginPage.qml")
            background: Rectangle {
                color: "#4CAF50"
                radius: 5
            }
        }

        Button {
            text: "Hospital Login"
            Layout.fillWidth: true
            font.pixelSize: 18
            onClicked: stackView.push("HospitalLoginPage.qml")
            background: Rectangle {
                color: "#2196F3"
                radius: 5
            }
        }

        Button {
            text: "Sign Up"
            Layout.fillWidth: true
            font.pixelSize: 18
            onClicked: stackView.push("SignUpPage.qml")
            background: Rectangle {
                color: "#FF5722"
                radius: 5
            }
        }

        Text {
            text: "Learn More About Blood Donation"
            color: "#1976D2"
            font.pixelSize: 16
            font.underline: true
            Layout.alignment: Qt.AlignHCenter
            MouseArea {
                anchors.fill: parent
                onClicked: stackView.push("InfoPage.qml")
            }
        }
    }
}
