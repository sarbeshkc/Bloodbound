// SignUpPage.qml
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    id: signupPage

    background: Rectangle {
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#4A90E2" }
            GradientStop { position: 1.0; color: "#FFFFFF" }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        width: 300

        Text {
            text: "Join Bloodbound"
            font.pixelSize: 24
            font.bold: true
            color: "#FFFFFF"
            Layout.alignment: Qt.AlignHCenter
        }

        Button {
            text: "User Signup"
            Layout.fillWidth: true
            font.pixelSize: 18
            onClicked: {
                stackView.push("UserSignUpPage.qml");
            }
            background: Rectangle {
                color: "#FF5733"
                radius: 5
            }
        }

        Button {
            text: "Hospital Signup"
            Layout.fillWidth: true
            font.pixelSize: 18
            onClicked: {
                stackView.push("HospitalSignUpPage.qml");
            }
            background: Rectangle {
                color: "#FF5733"
                radius: 5
            }
        }

        Button {
            text: "Learn More About Blood Donation"
            Layout.fillWidth: true
            font.pixelSize: 16
            onClicked: {
                stackView.push("LearnMorePage.qml");
            }
            background: Rectangle {
                color: "#4CAF50"
                radius: 5
            }
        }

        Text {
            text: "Already have an account? Log in"
            color: "#FFFFFF"
            font.pixelSize: 16
            font.underline: true
            Layout.alignment: Qt.AlignHCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    stackView.push("UserLoginPage.qml");
                }
            }
        }

        Text {
            text: "Back to Main Menu"
            color: "#FFFFFF"
            font.pixelSize: 16
            font.underline: true
            Layout.alignment: Qt.AlignHCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    stackView.pop();
                }
            }
        }
    }
}
