import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: hospitalSignupPage

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        RowLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.4
                color: window.primaryColor

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 20

                    Image {
                        source: "../../Pictures/Logo.png"
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: Math.min(parent.width * 0.6, parent.height * 0.3)
                        Layout.preferredHeight: Layout.preferredWidth
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        text: "Hospital Sign Up"
                        font.pixelSize: Math.min(parent.width * 0.15, 36)
                        font.bold: true
                        color: "white"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Text {
                        text: "Join BloodBound and help save lives"
                        font.pixelSize: Math.min(parent.width * 0.05, 18)
                        color: "white"
                        opacity: 0.8
                        Layout.alignment: Qt.AlignHCenter
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        Layout.preferredWidth: parent.width * 0.8
                    }
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "white"

                ScrollView {
                    anchors.fill: parent
                    clip: true

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 20
                        width: Math.min(parent.width * 0.8, 400)

                        TextField {
                            id: nameInput
                            placeholderText: "Hospital Name"
                            Layout.fillWidth: true
                            font.pixelSize: 14
                            background: Rectangle {
                                color: "#F0F0F0"
                                radius: 5
                                border.color: nameInput.activeFocus ? window.accentColor : "#CCCCCC"
                                border.width: nameInput.activeFocus ? 2 : 1
                            }
                            leftPadding: 10
                            rightPadding: 10
                            topPadding: 12
                            bottomPadding: 12
                        }

                        TextField {
                            id: emailInput
                            placeholderText: "Hospital Email Address"
                            Layout.fillWidth: true
                            font.pixelSize: 14
                            background: Rectangle {
                                color: "#F0F0F0"
                                radius: 5
                                border.color: emailInput.activeFocus ? window.accentColor : "#CCCCCC"
                                border.width: emailInput.activeFocus ? 2 : 1
                            }
                            leftPadding: 10
                            rightPadding: 10
                            topPadding: 12
                            bottomPadding: 12
                        }

                        TextField {
                            id: passwordInput
                            placeholderText: "Create Password"
                            echoMode: TextInput.Password
                            Layout.fillWidth: true
                            font.pixelSize: 14
                            background: Rectangle {
                                color: "#F0F0F0"
                                radius: 5
                                border.color: passwordInput.activeFocus ? window.accentColor : "#CCCCCC"
                                border.width: passwordInput.activeFocus ? 2 : 1
                            }
                            leftPadding: 10
                            rightPadding: 10
                            topPadding: 12
                            bottomPadding: 12
                        }

                        TextField {
                            id: confirmPasswordInput
                            placeholderText: "Confirm Password"
                            echoMode: TextInput.Password
                            Layout.fillWidth: true
                            font.pixelSize: 14
                            background: Rectangle {
                                color: "#F0F0F0"
                                radius: 5
                                border.color: confirmPasswordInput.activeFocus ? window.accentColor : "#CCCCCC"
                                border.width: confirmPasswordInput.activeFocus ? 2 : 1
                            }
                            leftPadding: 10
                            rightPadding: 10
                            topPadding: 12
                            bottomPadding: 12
                        }

                        Button {
                            text: "Sign Up"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.pixelSize: 16
                            font.bold: true
                            onClicked: signUp()
                            background: Rectangle {
                                color: window.accentColor
                                radius: 25
                            }
                            contentItem: Text {
                                text: parent.text
                                font: parent.font
                                color: "white"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        Text {
                            text: "Already have an account? Log in"
                            color: window.primaryColor
                            font.pixelSize: 14
                            font.underline: true
                            Layout.alignment: Qt.AlignHCenter
                            MouseArea {
                                anchors.fill: parent
                                onClicked: stackView.pop()
                            }
                        }
                    }
                }
            }
        }
    }

    Dialog {
        id: errorDialog
        title: "Error"
        standardButtons: Dialog.Ok

        contentItem: Text {
            id: errorText
            color: "#FF0000"
            font.pixelSize: 14
        }

        onAccepted: errorDialog.close()
    }

    function signUp() {
        var name = nameInput.text;
        var email = emailInput.text;
        var password = passwordInput.text;
        var confirmPassword = confirmPasswordInput.text;

        if (name.trim() === "" || email.trim() === "" || password.trim() === "" || confirmPassword.trim() === "") {
            errorText.text = "Please fill in all fields.";
            errorDialog.open();
            return;
        }

        if (password !== confirmPassword) {
            errorText.text = "Passwords do not match.";
            errorDialog.open();
            return;
        }

        var success = dbManager.insertHospital(name, email, password);
        if (success) {
            console.log("Hospital signup successful");
            stackView.push("HospitalDashboardPage.qml");
        } else {
            console.log("Hospital signup failed");
            errorText.text = "Signup failed. Please try again.";
            errorDialog.open();
        }
    }
}
