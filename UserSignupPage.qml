import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: userSignupPage

    property string selectedBloodGroup: ""
    property var inputFields: ({})

    Rectangle {
        anchors.fill: parent
        color: theme.backgroundColor

        RowLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.4
                color: theme.primaryColor

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 20
                    width: parent.width * 0.8

                    Image {
                        source: "../../Pictures/Logo.png"
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: Math.min(parent.width * 0.6, 200)
                        Layout.preferredHeight: Layout.preferredWidth
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        text: qsTr("Join BloodBound")
                        font: theme.headerFont
                        color: "white"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Label {
                        text: qsTr("Create your account and start saving lives")
                        font: theme.bodyFont
                        color: "white"
                        opacity: 0.8
                        Layout.alignment: Qt.AlignHCenter
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }

            ScrollView {
                Layout.fillHeight: true
                Layout.fillWidth: true
                clip: true

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 20
                    width: Math.min(parent.width * 0.8, 400)

                    Label {
                        text: qsTr("Sign Up")
                        font: theme.headerFont
                        color: theme.primaryColor
                        Layout.alignment: Qt.AlignHCenter
                    }

                    ColumnLayout {
                        spacing: 10
                        Layout.fillWidth: true

                        Repeater {
                            model: [
                                {placeholder: qsTr("Full Name"), field: "nameInput"},
                                {placeholder: qsTr("Email"), field: "emailInput"},
                                {placeholder: qsTr("Contact Number"), field: "contactNumberInput"},
                                {placeholder: qsTr("Address"), field: "addressInput"},
                                {placeholder: qsTr("Health conditions or allergies (optional)"), field: "healthInfoInput"},
                                {placeholder: qsTr("Password"), field: "passwordInput", isPassword: true},
                                {placeholder: qsTr("Confirm Password"), field: "confirmPasswordInput", isPassword: true}
                            ]

                            TextField {
                                Layout.fillWidth: true
                                placeholderText: modelData.placeholder
                                echoMode: modelData.isPassword ? TextInput.Password : TextInput.Normal
                                font: theme.bodyFont
                                color: theme.textColor
                                placeholderTextColor: Qt.lighter(theme.textColor, 1.5)
                                background: Rectangle {
                                    color: "#F8F8F8"
                                    radius: 5
                                    border.color: parent.activeFocus ? theme.accentColor : "#DDDDDD"
                                    border.width: parent.activeFocus ? 2 : 1
                                }
                                Component.onCompleted: {
                                    inputFields[modelData.field] = this
                                }
                            }
                        }

                        ComboBox {
                            id: bloodGroupComboBox
                            model: ["Select Blood Group", "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]
                            Layout.fillWidth: true
                            font: theme.bodyFont
                            onCurrentTextChanged: {
                                selectedBloodGroup = currentIndex !== 0 ? currentText : ""
                            }
                        }
                    }

                    Button {
                        text: qsTr("Sign Up")
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font: theme.buttonFont
                        onClicked: signUp()
                        background: Rectangle {
                            color: theme.accentColor
                            radius: 5
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
                        text: qsTr("Already have an account? Log in")
                        color: theme.accentColor
                        font: theme.bodyFont
                        Layout.alignment: Qt.AlignHCenter
                        MouseArea {
                            anchors.fill: parent
                            onClicked: stackView.push("UserLoginPage.qml")
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

        Label {
            id: errorText
            wrapMode: Text.WordWrap
        }
    }

    function signUp() {
        var name = inputFields.nameInput.text;
        var email = inputFields.emailInput.text;
        var password = inputFields.passwordInput.text;
        var confirmPassword = inputFields.confirmPasswordInput.text;
        var bloodGroup = selectedBloodGroup;
        var healthInfo = inputFields.healthInfoInput.text;
        var contactNumber = inputFields.contactNumberInput.text;
        var address = inputFields.addressInput.text;

        if (name.trim() === "" || email.trim() === "" || password.trim() === "" || confirmPassword.trim() === "" || bloodGroup === "" || contactNumber.trim() === "" || address.trim() === "") {
            errorText.text = "Please fill in all required fields.";
            errorDialog.open();
            return;
        }

        if (password !== confirmPassword) {
            errorText.text = "Passwords do not match.";
            errorDialog.open();
            return;
        }

        // Call the backend function to insert the user
        var success = dbManager.insertUser(name, email, password, bloodGroup, healthInfo);
        if (success) {
            // Update user profile with additional information
            var userData = {
                "name": name,
                "bloodGroup": bloodGroup,
                "healthInfo": healthInfo,
                "contactNumber": contactNumber,
                "address": address
            };
            success = dbManager.updateUserProfile(email, userData);
            if (success) {
                console.log("User signup successful");
                stackView.push("UserDashboardPage.qml", {"userEmail": email});
            } else {
                console.log("User profile update failed");
                errorText.text = "Signup partially successful. Please update your profile later.";
                errorDialog.open();
            }
        } else {
            console.log("User signup failed");
            errorText.text = "Signup failed. Please try again.";
            errorDialog.open();
        }
    }
}
