import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    id: window
    visible: true
    width: 1024
    height: 768
    title: "BloodBound"
    color: "#f5f5f5"

    property color primaryColor: "#FF5733"
    property color accentColor: "#4A90E2"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: mainMenuComponent
    }

    Component {
        id: mainMenuComponent


        Item {
            Rectangle {
                anchors.fill: parent
                color: "transparent"



                RowLayout {
                    anchors.fill: parent
                    spacing: 0

                    Rectangle {
                        Layout.fillHeight: true
                        Layout.preferredWidth: parent.width * 0.4
                        color: primaryColor

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 20
                            width: parent.width

                            Image {
                                source: "../../Pictures/Logo.png"
                                Layout.alignment: Qt.AlignHCenter
                                Layout.preferredWidth: Math.min(parent.width * 0.76, parent.height * 1.2)
                                Layout.preferredHeight: Layout.preferredWidth
                                fillMode: Image.PreserveAspectFit
                            }

                            Text {
                                text: "BloodBound"
                                font.pixelSize: Math.min(parent.width * 0.15, 48)
                                font.bold: true
                                color: "white"
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Text {
                                text: "Connecting donors and hospitals"
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
                        color: "transparent"

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 30
                            width: parent.width * 0.6

                            Button {
                                text: "Login"
                                Layout.preferredWidth: 300
                                Layout.preferredHeight: 60
                                font.pixelSize: 20
                                onClicked: stackView.push("LoginSignupChoicePage.qml", { mode: "login" })
                                background: Rectangle {
                                    color: accentColor
                                    radius: 30
                                }
                                contentItem: Text {
                                    text: parent.text
                                    font.bold: true
                                    color: "white"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }

                            Button {
                                text: "Sign Up"
                                Layout.preferredWidth: 300
                                Layout.preferredHeight: 60
                                font.pixelSize: 20
                                onClicked: stackView.push("LoginSignupChoicePage.qml", { mode: "signup" })
                                background: Rectangle {
                                    color: "white"
                                    border.color: accentColor
                                    border.width: 2
                                    radius: 30
                                }
                                contentItem: Text {
                                    text: parent.text
                                    font.bold: true
                                    color: accentColor
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }

                            Button {
                                text: "Learn More"
                                Layout.preferredWidth: 300
                                Layout.preferredHeight: 50
                                font.pixelSize: 18
                                onClicked: stackView.push("LearnMorePage.qml")
                                background: Rectangle {
                                    color: "transparent"
                                    border.color: primaryColor
                                    border.width: 2
                                    radius: 25
                                }
                                contentItem: Text {
                                    text: parent.text
                                    font.bold: true
                                    color: primaryColor
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }
                    }
                }

                Text {
                    text: "© 2024 BloodBound. All rights reserved."
                    font.pixelSize: 15
                    color: "#666666"
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.bottomMargin: 10
                    anchors.leftMargin: 60
                }
            }
        }
    }
}
