
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    id: window
    visible: true
    width: 1024
    height: 768
    title: qsTr("BloodBound")
    color: "#F5F5F5"  // Light background color

    QtObject {
        id: theme
        property color primaryColor: "#FF5733"
        property color accentColor: "#4A90E2"
        property color backgroundColor: "#F5F5F5"
        property color textColor: "#333333"
        property font headerFont: Qt.font({ family: "Segoe UI", pixelSize: 24, weight: Font.DemiBold })
        property font bodyFont: Qt.font({ family: "Segoe UI", pixelSize: 16 })
        property font buttonFont: Qt.font({ family: "Segoe UI", pixelSize: 16, weight: Font.Medium })
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: mainMenuComponent
    }

    Component {
        id: mainMenuComponent

        Rectangle {
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
                            text: qsTr("Welcome to BloodBound")
                            font: theme.headerFont
                            color: theme.textColor
                            Layout.alignment: Qt.AlignHCenter
                        }

                        TabBar {
                            id: tabBar
                            Layout.fillWidth: true
                            TabButton {
                                text: qsTr("Donor")
                                width: implicitWidth
                            }
                            TabButton {
                                text: qsTr("Hospital")
                                width: implicitWidth
                            }
                        }

                        StackLayout {
                            currentIndex: tabBar.currentIndex
                            Layout.fillWidth: true

                            // Donor options
                            ColumnLayout {
                                spacing: 10
                                Button {
                                    text: qsTr("Donor Login")
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font: theme.buttonFont
                                    onClicked: stackView.push("UserLoginPage.qml")
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
                                Button {
                                    text: qsTr("Donor Sign Up")
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font: theme.buttonFont
                                    onClicked: stackView.push("UserSignupPage.qml")
                                    background: Rectangle {
                                        color: "transparent"
                                        border.color: theme.accentColor
                                        border.width: 1
                                        radius: 5
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        font: parent.font
                                        color: theme.accentColor
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                }
                            }

                            // Hospital options
                            ColumnLayout {
                                spacing: 10
                                Button {
                                    text: qsTr("Hospital Login")
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font: theme.buttonFont
                                    onClicked: stackView.push("HospitalLoginPage.qml")
                                    background: Rectangle {
                                        color: theme.primaryColor
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
                                Button {
                                    text: qsTr("Hospital Sign Up")
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font: theme.buttonFont
                                    onClicked: stackView.push("HospitalSignupPage.qml")
                                    background: Rectangle {
                                        color: "transparent"
                                        border.color: theme.primaryColor
                                        border.width: 1
                                        radius: 5
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        font: parent.font
                                        color: theme.primaryColor
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                }
                            }
                        }

                        Item { height: 20 } // Spacer

                        Text {
                            text: qsTr("Learn More About BloodBound")
                            color: theme.accentColor
                            font: theme.bodyFont
                            Layout.alignment: Qt.AlignHCenter
                            MouseArea {
                                anchors.fill: parent
                                onClicked: stackView.push("LearnMorePage.qml")
                            }
                        }
                    }
                }
            }
        }
    }
}
