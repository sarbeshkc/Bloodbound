import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: userLoginPage

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
                        text: qsTr("BloodBound")
                        font: theme.headerFont
                        color: "white"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Label {
                        text: qsTr("Connecting donors and hospitals")
                        font: theme.bodyFont
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
                        font: theme.headerFont
                        color: theme.primaryColor
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Label {
                        text: qsTr("We're so excited to see you again!")
                        font: theme.bodyFont
                        color: theme.textColor
                        opacity: 0.7
                        Layout.alignment: Qt.AlignHCenter
                    }

                    TextField {
                        id: emailInput
                        placeholderText: qsTr("Email")
                        Layout.fillWidth: true
                        font: theme.bodyFont
                        color: theme.textColor
                        placeholderTextColor: Qt.lighter(theme.textColor, 1.5)
                        background: Rectangle {
                            color: "#F8F8F8"
                            radius: 5
                            border.color: emailInput.activeFocus ? theme.accentColor : "#DDDDDD"
                            border.width: emailInput.activeFocus ? 2 : 1
                        }
                        leftPadding: 16
                        rightPadding: 16
                        topPadding: 14
                        bottomPadding: 14
                    }

                    TextField {
                        id: passwordInput
                        placeholderText: qsTr("Password")
                        echoMode: TextInput.Password
                        Layout.fillWidth: true
                        font: theme.bodyFont
                        color: theme.textColor
                        placeholderTextColor: Qt.lighter(theme.textColor, 1.5)
                        background: Rectangle {
                            color: "#F8F8F8"
                            radius: 5
                            border.color: passwordInput.activeFocus ? theme.accentColor : "#DDDDDD"
                            border.width: passwordInput.activeFocus ? 2 : 1
                        }
                        leftPadding: 16
                        rightPadding: 16
                        topPadding: 14
                        bottomPadding: 14
                    }

                    Button {
                        text: qsTr("Login")
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font: theme.buttonFont
                        onClicked: login()
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
                        text: qsTr("Need an account? Sign up")
                        color: theme.accentColor
                        font: theme.bodyFont
                        Layout.alignment: Qt.AlignHCenter
                        MouseArea {
                            anchors.fill: parent
                            onClicked: stackView.push("UserSignupPage.qml")
                        }
                    }

                    Item { height: 20 } // Spacer

                    Text {
                        text: qsTr("Back to Main Menu")
                        color: theme.primaryColor
                        font: theme.bodyFont
                        Layout.alignment: Qt.AlignHCenter
                        MouseArea {
                            anchors.fill: parent
                            onClicked: stackView.push("MainView.qml")
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
                text: qsTr("Login Failed")
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
