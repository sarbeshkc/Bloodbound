import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: hospitalSignupPage

    property alias nameInput: nameField.text
    property alias emailInput: emailField.text
    property alias contactNumberInput: contactNumberField.text
    property alias addressInput: addressField.text
    property alias cityInput: cityField.text
    property alias stateInput: stateField.text
    property alias countryInput: countryField.text
    property alias zipInput: zipField.text
    property alias licenseInput: licenseField.text
    property alias passwordInput: passwordField.text
    property alias confirmPasswordInput: confirmPasswordField.text

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
                        text: qsTr("Hospital Sign Up")
                        font: theme.headerFont
                        color: "white"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Label {
                        text: qsTr("Join BloodBound and help save lives")
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
                        text: qsTr("Hospital Registration")
                        font: theme.headerFont
                        color: theme.primaryColor
                        Layout.alignment: Qt.AlignHCenter
                    }

                    ColumnLayout {
                        spacing: 10
                        Layout.fillWidth: true

                        CustomTextField {
                            id: nameField
                            placeholderText: qsTr("Hospital Name")
                        }

                        CustomTextField {
                            id: emailField
                            placeholderText: qsTr("Email Address")
                            inputMethodHints: Qt.ImhEmailCharactersOnly
                        }

                        CustomTextField {
                            id: contactNumberField
                            placeholderText: qsTr("Contact Number")
                            inputMethodHints: Qt.ImhDialableCharactersOnly
                        }

                        CustomTextField {
                            id: addressField
                            placeholderText: qsTr("Address")
                        }

                        CustomTextField {
                            id: cityField
                            placeholderText: qsTr("City")
                        }

                        CustomTextField {
                            id: stateField
                            placeholderText: qsTr("State/Province")
                        }

                        CustomTextField {
                            id: countryField
                            placeholderText: qsTr("Country")
                        }

                        CustomTextField {
                            id: zipField
                            placeholderText: qsTr("Zip/Postal Code")
                            inputMethodHints: Qt.ImhDigitsOnly
                        }

                        CustomTextField {
                            id: licenseField
                            placeholderText: qsTr("License Number")
                        }

                        CustomTextField {
                            id: passwordField
                            placeholderText: qsTr("Password")
                            echoMode: TextInput.Password
                        }

                        CustomTextField {
                            id: confirmPasswordField
                            placeholderText: qsTr("Confirm Password")
                            echoMode: TextInput.Password
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
                            onClicked: stackView.pop()
                        }
                    }
                }
            }
        }
    }

    // Error dialog
    Popup {
        id: errorDialog
        anchors.centerIn: parent
        width: 300
        height: 150
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        background: Rectangle {
            color: "white"
            border.color: theme.primaryColor
            border.width: 2
            radius: 10
        }

        contentItem: ColumnLayout {
            spacing: 20
            Label {
                text: qsTr("Error")
                font: theme.headerFont
                color: theme.primaryColor
                Layout.alignment: Qt.AlignHCenter
            }
            Label {
                id: errorText
                color: theme.textColor
                font: theme.bodyFont
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }
            Button {
                text: qsTr("OK")
                font: theme.buttonFont
                Layout.alignment: Qt.AlignHCenter
                onClicked: errorDialog.close()
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
        }
    }

    function signUp() {
        if (!validateInputs()) {
            return;
        }

        // Call the backend function to insert the hospital
        var success = dbManager.insertHospital(
            nameInput,
            emailInput,
            passwordInput,
            contactNumberInput,
            addressInput,
            cityInput,
            stateInput,
            countryInput,
            zipInput,
            licenseInput
        );

        if (success) {
            console.log("Hospital signup successful");
            stackView.push("HospitalDashboardPage.qml", {"hospitalEmail": emailInput});
        } else {
            console.log("Hospital signup failed");
            showError("Signup failed. Please try again.");
        }
    }

    function validateInputs() {
        if (nameInput.trim() === "" || emailInput.trim() === "" || passwordInput.trim() === "" ||
            confirmPasswordInput.trim() === "" || contactNumberInput.trim() === "" ||
            addressInput.trim() === "" || cityInput.trim() === "" || stateInput.trim() === "" ||
            countryInput.trim() === "" || zipInput.trim() === "" || licenseInput.trim() === "") {
            showError("Please fill in all fields.");
            return false;
        }

        if (passwordInput !== confirmPasswordInput) {
            showError("Passwords do not match.");
            return false;
        }

        if (!isValidEmail(emailInput)) {
            showError("Please enter a valid email address.");
            return false;
        }

        return true;
    }

    function isValidEmail(email) {
        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    function showError(message) {
        errorText.text = message;
        errorDialog.open();
    }

    component CustomTextField: TextField {
        Layout.fillWidth: true
        font: theme.bodyFont
        color: theme.textColor
        placeholderTextColor: Qt.lighter(theme.textColor, 1.5)
        background: Rectangle {
            color: "#F8F8F8"
            radius: 5
            border.color: parent.activeFocus ? theme.accentColor : "#DDDDDD"
            border.width: parent.activeFocus ? 2 : 1
        }
    }
}
