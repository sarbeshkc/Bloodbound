import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    id: resetPasswordPage

    // Background image
    // Image {
    //     anchors.fill: parent
    //     source: "/home/satvara/Downloads/GIve_me_a_icon_for_a_app_called_bloodbound_and_it_should_be_related_to_donating_blood_png.png"
    //     fillMode: Image.PreserveAspectCrop
    //     opacity: 0.6
    // }

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

        // Logo if needed
        // Image {
        //     source: "/path/to/your/logo.png"
        //     fillMode: Image.PreserveAspectFit
        //     Layout.alignment: Qt.AlignHCenter
        //     Layout.preferredWidth: 200
        //     Layout.preferredHeight: 200
        //     Layout.maximumWidth: 200
        //     Layout.maximumHeight: 200
        // }

        // Email input
        TextField {
            id: emailInput
            placeholderText: "Email"
            Layout.fillWidth: true
             font.pixelSize: 18
             background: Rectangle {
                 color: "#FFFFFF"
                 radius: 5
                 border.color: nameInput.focus ? "#FF5733" : "#CCCCCC"
                 border.width: nameInput.focus ? 2 : 1
             }
             leftPadding: 10
             rightPadding: 10
             topPadding: 8
             bottomPadding: 8
             onFocusChanged: {
                 if (focus) {
                     color = "#333333"
                 } else {
                     color = "#666666"
                 }
             }
         }

        // New password input
        TextField {
            id: newPasswordInput
            placeholderText: "New Password"
            echoMode: TextInput.Password
            Layout.fillWidth: true
             font.pixelSize: 18
             background: Rectangle {
                 color: "#FFFFFF"
                 radius: 5
                 border.color: nameInput.focus ? "#FF5733" : "#CCCCCC"
                 border.width: nameInput.focus ? 2 : 1
             }
             leftPadding: 10
             rightPadding: 10
             topPadding: 8
             bottomPadding: 8
             onFocusChanged: {
                 if (focus) {
                     color = "#333333"
                 } else {
                     color = "#666666"
                 }
             }
         }

        // Reset password button
        Button {
            text: "Reset Password"
            Layout.fillWidth: true
            font.pixelSize: 18
            onClicked: {
                var success = dbManager.resetPassword(emailInput.text, newPasswordInput.text);
                if (success) {
                    console.log("Password reset successful");
                    // Navigate back to the login screen
                    stackView.pop();
                } else {
                    console.log("Password reset failed");
                }
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
                    // Navigate back to the login screen
                    stackView.pop();
                }
            }
        }
    }
}
