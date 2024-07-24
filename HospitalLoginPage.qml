import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: hospitalLoginPage

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

                Image {
                    id: backgroundImage
                    source: "../../Pictures/hospital-background.jpg"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    opacity: 0.3
                }

                Rectangle {
                    anchors.fill: parent
                    color: theme.primaryColor
                    opacity: 0.7
                }

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
                        font {
                            family: theme.headerFont.family
                            pixelSize: 36
                            weight: Font.Bold
                        }
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
                    spacing: 30
                    width: Math.min(parent.width * 0.8, 400)

                    Label {
                        text: qsTr("Hospital Login")
                        font {
                            family: theme.headerFont.family
                            pixelSize: 28
                            weight: Font.Bold
                        }
                        color: theme.primaryColor
                        Layout.alignment: Qt.AlignHCenter
                    }

                    CustomTextField {
                        id: emailInput
                        placeholderText: qsTr("Email")
                        inputMethodHints: Qt.ImhEmailCharactersOnly
                    }

                    CustomTextField {
                        id: passwordInput
                        placeholderText: qsTr("Password")
                        echoMode: TextInput.Password
                    }

                    Button {
                        id: loginButton
                        text: qsTr("Login")
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font: theme.buttonFont
                        onClicked: login()

                        background: Rectangle {
                            color: loginButton.pressed ? Qt.darker(theme.accentColor, 1.1) : theme.accentColor
                            radius: 5

                            // Simple shadow effect
                            Rectangle {
                                anchors.fill: parent
                                anchors.margins: -2
                                color: "transparent"
                                radius: 7
                                border.color: "#80000000"
                                border.width: 2
                                z: -1
                            }
                        }

                        contentItem: Text {
                            text: loginButton.text
                            font: loginButton.font
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Text {
                        text: qsTr("Don't have an account? Sign up")
                        color: theme.accentColor
                        font.pixelSize: 14
                        Layout.alignment: Qt.AlignHCenter
                        MouseArea {
                            anchors.fill: parent
                            onClicked: stackView.push("HospitalSignupPage.qml")
                            cursorShape: Qt.PointingHandCursor
                        }
                    }

                    Text {
                        text: qsTr("Back to Main Menu")
                        color: theme.primaryColor
                        font.pixelSize: 14
                        Layout.alignment: Qt.AlignHCenter
                        MouseArea {
                            anchors.fill: parent
                            onClicked: stackView.pop()
                            cursorShape: Qt.PointingHandCursor
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
        height: 200
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        background: Rectangle {
            color: theme.backgroundColor
            border.color: theme.primaryColor
            border.width: 2
            radius: 10
        }

        contentItem: ColumnLayout {
            spacing: 20
            Label {
                text: qsTr("Login Failed")
                font.pixelSize: 20
                font.weight: Font.Bold
                color: theme.primaryColor
                Layout.alignment: Qt.AlignHCenter
            }
            Label {
                id: errorText
                color: theme.textColor
                font.pixelSize: 14
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                Layout.leftMargin: 20
                Layout.rightMargin: 20
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
        var email = emailInput.text.trim()
        var password = passwordInput.text.trim()

        if (email === "" || password === "") {
            showError("Please enter both email and password.")
            return
        }

        var success = dbManager.hospitalLogin(email, password)
        if (success) {
            stackView.push("HospitalDashboardPage.qml", {"hospitalEmail": email})
        } else {
            showError("Invalid email or password. Please try again.")
        }
    }

    function showError(message) {
        errorText.text = message
        errorDialog.open()
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
        leftPadding: 16
        rightPadding: 16
        topPadding: 14
        bottomPadding: 14
    }
}
