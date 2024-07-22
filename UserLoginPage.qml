import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs

Page {
    id: userLoginPage

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

        TextField {
            id: emailInput
            placeholderText: "Enter your email address"
            Layout.fillWidth: true
            font.pixelSize: 18
            background: Rectangle {
                color: "#FFFFFF"
                radius: 5
                border.color: emailInput.activeFocus ? "#4CAF50" : "#CCCCCC"
                border.width: emailInput.activeFocus ? 2 : 1
            }
            leftPadding: 10
            rightPadding: 10
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            TextField {
                id: passwordInput
                placeholderText: "Enter your password"
                echoMode: TextInput.Password
                Layout.fillWidth: true
                font.pixelSize: 18
                background: Rectangle {
                    color: "#FFFFFF"
                    radius: 5
                    border.color: passwordInput.activeFocus ? "#4CAF50" : "#CCCCCC"
                    border.width: passwordInput.activeFocus ? 2 : 1
                }
                leftPadding: 10
                rightPadding: 10
            }

            Button {
                id: togglePasswordVisibility
                text: passwordInput.echoMode === TextInput.Normal ? "Hide" : "Show"
                onClicked: {
                    passwordInput.echoMode = passwordInput.echoMode === TextInput.Normal ? TextInput.Password : TextInput.Normal
                }
                background: Rectangle {
                    color: "#4CAF50"
                    radius: 5
                }
                contentItem: Text {
                    text: togglePasswordVisibility.text
                    font.pixelSize: 14
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }

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
                    stackView.push("UserDashboardPage.qml");
                } else {
                    console.log("User login failed");
                    errorDialog.open();
                }
            }
            background: Rectangle {
                color: "#4CAF50"
                radius: 5
            }
        }

        Text {
            text: "Forgot Password?"
            color: "#4A90E2"
            font.pixelSize: 16
            font.underline: true
            Layout.alignment: Qt.AlignHCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    stackView.push("PasswordResetPage.qml");
                }
            }
        }

        Text {
            text: "Don't have an account? Sign up"
            color: "#4A90E2"
            font.pixelSize: 16
            font.underline: true
            Layout.alignment: Qt.AlignHCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    stackView.push("UserSignupPage.qml");
                }
            }
        }

        Text {
            text: "Back to Main Menu"
            color: "#4A90E2"
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

    Dialog {
        id: errorDialog
        title: "Login Failed"
        standardButtons: Dialog.Ok

        contentItem: Text {
            text: "Invalid email or password. Please try again."
            color: "#FF0000"
            font.pixelSize: 14
        }

        onAccepted: {
            errorDialog.close();
        }
    }
}
