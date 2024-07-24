import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs

Item {
    id: userLoginPage

    Rectangle {
        anchors.fill: parent
        color: window.backgroundColor

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
                    width: parent.width * 0.8

                    Image {
                        source: "../../Pictures/Logo.png"
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: Math.min(parent.width * 0.6, 200)
                        Layout.preferredHeight: Layout.preferredWidth
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        text: qsTr("BloodBound")
                        font: window.theme.headerFont
                        color: "white"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Label {
                        text: qsTr("Connecting donors and hospitals")
                        font: window.theme.bodyFont
                        color: "white"
                        opacity: 0.8
                        Layout.alignment: Qt.AlignHCenter
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "white"

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 20
                    width: Math.min(parent.width * 0.8, 400)

                    Label {
                        text: qsTr("Welcome back!")
                        font: window.theme.headerFont
                        color: window.primaryColor
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Label {
                        text: qsTr("We're so excited to see you again!")
                        font: window.theme.bodyFont
                        color: window.textColor
                        opacity: 0.7
                        Layout.alignment: Qt.AlignHCenter
                    }

                    CustomTextField {
                        id: emailInput
                        placeholderText: qsTr("Email")
                        Layout.fillWidth: true
                    }

                    CustomTextField {
                        id: passwordInput
                        placeholderText: qsTr("Password")
                        echoMode: TextInput.Password
                        Layout.fillWidth: true
                    }

                    Button {
                        text: qsTr("Login")
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font: window.theme.buttonFont
                        onClicked: login()
                        background: Rectangle {
                            color: window.accentColor
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
                        text: qsTr("Need an account? Sign up")
                        color: window.accentColor
                        font: window.theme.bodyFont
                        Layout.alignment: Qt.AlignHCenter
                        MouseArea {
                            anchors.fill: parent
                            onClicked: stackView.push("UserSignupPage.qml")
                        }
                    }

                    Item { height: 20 } // Spacer

                    Text {
                        text: qsTr("Back to Main Menu")
                        color: window.primaryColor
                        font: window.theme.bodyFont
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

    Dialog {
        id: errorDialog
        title: qsTr("Login Failed")
        standardButtons: Dialog.Ok

        contentItem: Text {
            id: errorText
            color: "#FF0000"
            font: window.theme.bodyFont
            wrapMode: Text.WordWrap
        }

        onAccepted: errorDialog.close()
    }

    // Custom TextField component
    component CustomTextField: TextField {
        id: customField
        font: window.theme.bodyFont
        placeholderTextColor: "#AAAAAA"
        color: window.textColor
        background: Rectangle {
            color: "#F8F8F8"
            radius: 5
            border.color: customField.activeFocus ? window.accentColor : "#DDDDDD"
            border.width: customField.activeFocus ? 2 : 1
        }
        leftPadding: 16
        rightPadding: 16
        topPadding: 14
        bottomPadding: 14
    }

    function login() {
        var email = emailInput.text;
        var password = passwordInput.text;

        if (email.trim() === "" || password.trim() === "") {
            errorText.text = qsTr("Please enter both email and password.");
            errorDialog.open();
            return;
        }

        var success = dbManager.userLogin(email, password);
        if (success) {
            console.log("User login successful");
            var userData = dbManager.getUserData(email);
            stackView.push("UserDashboardPage.qml", {"userEmail": email, "userData": userData});
        } else {
            console.log("User login failed");
            errorText.text = qsTr("Invalid email or password. Please try again.");
            errorDialog.open();
        }
    }
}
