import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    id: signupPage

    // Background image
    Image {
        anchors.fill: parent
        source: "/home/satvara/Downloads/GIve_me_a_icon_for_a_app_called_bloodbound_and_it_should_be_related_to_donating_blood_png.png"
        fillMode: Image.PreserveAspectCrop
        opacity: 0.6
    }

    // Background overlay rectangle
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.5
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        width: 300

        // User signup button
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

        // Hospital signup button
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

        // Login link
        Text {
            text: "Back to Login"
            color: "#FFFFFF"
            font.pixelSize: 16
            font.underline: true
            Layout.alignment: Qt.AlignHCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    // Navigate back to the login page
                    stackView.pop();
                }
            }
        }
    }
}
