import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.platform 1.1

Page {
    id: userSignupPage

    property string selectedPhotoUrl: ""

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

        Button {
            text: "Select Profile Photo"
            Layout.fillWidth: true
            font.pixelSize: 18
            onClicked: {
                fileDialog.open()
            }
            background: Rectangle {
                color: "#FF5733"
                radius: 5
            }
        }

        Image {
            id: photoPreview
            source: selectedPhotoUrl
            fillMode: Image.PreserveAspectFit
            Layout.preferredWidth: 200
            Layout.preferredHeight: 200
            visible: selectedPhotoUrl !== ""
            Layout.alignment: Qt.AlignHCenter
        }

        TextField {
            id: nameInput
            placeholderText: "Enter your full name"
            Layout.fillWidth: true
            font.pixelSize: 18
            background: Rectangle {
                color: "#FFFFFF"
                radius: 5
                border.color: nameInput.activeFocus ? "#FF5733" : "#CCCCCC"
                border.width: nameInput.activeFocus ? 2 : 1
            }
            leftPadding: 10
            rightPadding: 10
        }

        TextField {
            id: emailInput
            placeholderText: "Enter your email address"
            Layout.fillWidth: true
            font.pixelSize: 18
            background: Rectangle {
                color: "#FFFFFF"
                radius: 5
                border.color: emailInput.activeFocus ? "#FF5733" : "#CCCCCC"
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
                placeholderText: "Create a password"
                echoMode: TextInput.Password
                Layout.fillWidth: true
                font.pixelSize: 18
                background: Rectangle {
                    color: "#FFFFFF"
                    radius: 5
                    border.color: passwordInput.activeFocus ? "#FF5733" : "#CCCCCC"
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
                    color: "#FF5733"
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

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            TextField {
                id: confirmPasswordInput
                placeholderText: "Confirm your password"
                echoMode: TextInput.Password
                Layout.fillWidth: true
                font.pixelSize: 18
                background: Rectangle {
                    color: "#FFFFFF"
                    radius: 5
                    border.color: confirmPasswordInput.activeFocus ? "#FF5733" : "#CCCCCC"
                    border.width: confirmPasswordInput.activeFocus ? 2 : 1
                }
                leftPadding: 10
                rightPadding: 10
            }

            Button {
                id: toggleConfirmPasswordVisibility
                text: confirmPasswordInput.echoMode === TextInput.Normal ? "Hide" : "Show"
                onClicked: {
                    confirmPasswordInput.echoMode = confirmPasswordInput.echoMode === TextInput.Normal ? TextInput.Password : TextInput.Normal
                }
                background: Rectangle {
                    color: "#FF5733"
                    radius: 5
                }
                contentItem: Text {
                    text: toggleConfirmPasswordVisibility.text
                    font.pixelSize: 14
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }

        Button {
            text: "Sign Up"
            Layout.fillWidth: true
            font.pixelSize: 18
            onClicked: {
                var name = nameInput.text;
                var email = emailInput.text;
                var password = passwordInput.text;
                var confirmPassword = confirmPasswordInput.text;
                var photoUrl = selectedPhotoUrl;

                if (password === confirmPassword) {
                    var success = dbManager.insertUser(name, email, password, photoUrl);
                    if (success) {
                        console.log("User signup successful");
                        stackView.push("UserDashboardPage.qml");
                    } else {
                        console.log("User signup failed");
                        // Show an error message
                    }
                } else {
                    console.log("Passwords do not match");
                    // Show an error message indicating that the passwords do not match
                }
            }
            background: Rectangle {
                color: "#FF5733"
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
                    stackView.pop();
                }
            }
        }
    }
}
