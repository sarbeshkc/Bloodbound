import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: mainMenuPage

    background: Rectangle {
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#FF5733" }
            GradientStop { position: 1.0; color: "#FFFFFF" }
        }
    }

    Rectangle {
        id: menuCard
        width: parent.width * 0.8
        height: parent.height * 0.8
        anchors.centerIn: parent
        color: "white"
        radius: 10

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20

            Image {
                source: "qrc:/assets/logo.png" // Make sure to add your logo to the resources
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 100
                Layout.preferredHeight: 100
            }

            Text {
                text: "BloodBound"
                font.pixelSize: 32
                font.bold: true
                color: "#FF5733"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "Connecting donors and hospitals"
                font.pixelSize: 16
                color: "#666666"
                Layout.alignment: Qt.AlignHCenter
            }

            Item { Layout.preferredHeight: 20 } // Spacer

            Button {
                text: "Login"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                font.pixelSize: 18
                onClicked: stackView.push("LoginChoicePage.qml")
                background: Rectangle {
                    color: "#FF5733"
                    radius: 5
                }
                contentItem: Text {
                    text: parent.text
                    font.bold: true
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Button {
                text: "Sign Up"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                font.pixelSize: 18
                onClicked: stackView.push("SignUpPage.qml")
                background: Rectangle {
                    color: "#FF5733"
                    radius: 5
                }
                contentItem: Text {
                    text: parent.text
                    font.bold: true
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Item { Layout.preferredHeight: 10 } // Spacer

            Button {
                text: "Learn More"
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                font.pixelSize: 16
                onClicked: stackView.push("LearnMorePage.qml")
                background: Rectangle {
                    color: "transparent"
                    border.color: "#FF5733"
                    border.width: 2
                    radius: 5
                }
                contentItem: Text {
                    text: parent.text
                    font.bold: true
                    color: "#FF5733"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Item { Layout.fillHeight: true } // Spacer

            Text {
                text: "© 2024 BloodBound. All rights reserved."
                font.pixelSize: 12
                color: "#666666"
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
