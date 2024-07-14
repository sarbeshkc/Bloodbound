import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs

Page {
    id: userLoginPage


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

        TextField {
            id: emailInput
            placeholderText: "Email"
            Layout.fillWidth: true
             font.pixelSize: 18
             background: Rectangle {
                 color: "#FFFFFF"
                 radius: 5
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


        TextField {
            id: passwordInput
            placeholderText: "Password"
            echoMode: TextInput.Password
            Layout.fillWidth: true
             font.pixelSize: 18
             background: Rectangle {
                 color: "#FFFFFF"
                 radius: 5
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

        // Login button
        Button {
            text: "Login"
            Layout.fillWidth: true
            font.pixelSize: 18
            onClicked: {
                var email = emailInput.text;
                var password = passwordInput.text;
                var success = dbManager.userLogin(email, password);
                if (success) {
                    console.log("User login successful");
                    // Navigate to the user dashboard
                    stackView.push("UserDashboardPage.qml");
                } else {
                    console.log("User login failed");
                    errorDialog.open();

                }
            }
            background: Rectangle {
                color: "#FF5733"
                radius: 5
            }
        }
        Dialog {
            id: errorDialog
            title: "Login Failed"
            standardButtons: Dialog.Ok
            modal: true

            contentItem: Text {
                text: "Invalid email or password. Please try again."
            }
            onOpened: {
                var centerX = (parent.width - width) / 2;
                var centerY = (parent.height - height) / 2;
                x = centerX;
                y = centerY;
            }
        }
        // main login page link
        Text {
            text: "Back to Login"
            color: "#FFFFFF"
            font.pixelSize: 16
            font.underline: true
            Layout.alignment: Qt.AlignHCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    // to the main login page
                    stackView.pop();
                }
            }
            }
    }
}