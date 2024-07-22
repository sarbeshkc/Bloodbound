import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    id: hospitalSignupPage

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
            id: nameInput
            placeholderText: "Enter hospital name"
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
            placeholderText: "Enter hospital email address"
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

                if (password === confirmPassword) {
                    var success = dbManager.insertHospital(name, email, password);
                    if (success) {
                        console.log("Hospital signup successful");
                        stackView.push("HospitalDashboardPage.qml");
                    } else {
                        console.log("Hospital signup failed");
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
