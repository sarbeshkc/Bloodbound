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
    color: "#F5F5F5"

    QtObject {
        id: theme
        property color primaryColor: "#E53935"
        property color accentColor: "#1E88E5"
        property color backgroundColor: "#FFFFFF"
        property color textColor: "#212121"
        property color lightTextColor: "#757575"
        property font headerFont: Qt.font({ family: "Segoe UI", pixelSize: 32, weight: Font.Bold })
        property font subHeaderFont: Qt.font({ family: "Segoe UI", pixelSize: 24, weight: Font.DemiBold })
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

                    Image {
                        id: backgroundImage
                        source: "../../Pictures/blood-donation-background.jpg"
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectCrop
                        opacity: 0.2
                    }

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 30
                        width: parent.width * 0.8

                        Image {
                            source: "../../Pictures/Logo.png"
                            Layout.alignment: Qt.AlignHCenter
                            Layout.preferredWidth: Math.min(parent.width * 0.6, 180)
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
                            opacity: 0.9
                            Layout.alignment: Qt.AlignHCenter
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }

                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: theme.backgroundColor

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 30
                        width: Math.min(parent.width * 0.8, 400)

                        Label {
                            text: qsTr("Welcome to BloodBound")
                            font: theme.subHeaderFont
                            color: theme.textColor
                            Layout.alignment: Qt.AlignHCenter
                        }

                        TabBar {
                            id: tabBar
                            Layout.fillWidth: true
                            background: Rectangle {
                                color: "transparent"
                            }

                            Repeater {
                                model: ["Donor", "Hospital"]
                                TabButton {
                                    text: modelData
                                    width: implicitWidth
                                    font: theme.buttonFont
                                    contentItem: Text {
                                        text: parent.text
                                        font: parent.font
                                        opacity: parent.checked ? 1.0 : 0.7
                                        color: parent.checked ? theme.primaryColor : theme.textColor
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    background: Rectangle {
                                        color: "transparent"
                                        Rectangle {
                                            width: parent.width
                                            height: 3
                                            anchors.bottom: parent.bottom
                                            color: parent.checked ? theme.primaryColor : "transparent"
                                        }
                                    }
                                }
                            }
                        }

                        StackLayout {
                            currentIndex: tabBar.currentIndex
                            Layout.fillWidth: true

                            // Donor options
                            ColumnLayout {
                                spacing: 15
                                Repeater {
                                    model: [
                                        { text: "Donor Login", page: "UserLoginPage.qml", primary: true },
                                        { text: "Donor Sign Up", page: "UserSignupPage.qml", primary: false }
                                    ]
                                    Button {
                                        text: modelData.text
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 50
                                        font: theme.buttonFont
                                        onClicked: stackView.push(modelData.page)
                                        background: Rectangle {
                                            color: modelData.primary ? theme.accentColor : "transparent"
                                            border.color: theme.accentColor
                                            border.width: modelData.primary ? 0 : 2
                                            radius: 25
                                        }
                                        contentItem: Text {
                                            text: parent.text
                                            font: parent.font
                                            color: modelData.primary ? "white" : theme.accentColor
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }

                                        Behavior on scale {
                                            NumberAnimation {
                                                duration: 100
                                                easing.type: Easing.InOutQuad
                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            cursorShape: Qt.PointingHandCursor
                                            onEntered: parent.scale = 1.05
                                            onExited: parent.scale = 1.0
                                            onClicked: parent.clicked()
                                        }
                                    }
                                }
                            }

                            // Hospital options
                            ColumnLayout {
                                spacing: 15
                                Repeater {
                                    model: [
                                        { text: "Hospital Login", page: "HospitalLoginPage.qml", primary: true },
                                        { text: "Hospital Sign Up", page: "HospitalSignupPage.qml", primary: false }
                                    ]
                                    Button {
                                        text: modelData.text
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 50
                                        font: theme.buttonFont
                                        onClicked: stackView.push(modelData.page)
                                        background: Rectangle {
                                            color: modelData.primary ? theme.primaryColor : "transparent"
                                            border.color: theme.primaryColor
                                            border.width: modelData.primary ? 0 : 2
                                            radius: 25
                                        }
                                        contentItem: Text {
                                            text: parent.text
                                            font: parent.font
                                            color: modelData.primary ? "white" : theme.primaryColor
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }

                                        Behavior on scale {
                                            NumberAnimation {
                                                duration: 100
                                                easing.type: Easing.InOutQuad
                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            cursorShape: Qt.PointingHandCursor
                                            onEntered: parent.scale = 1.05
                                            onExited: parent.scale = 1.0
                                            onClicked: parent.clicked()
                                        }
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
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true
                                onEntered: parent.font.underline = true
                                onExited: parent.font.underline = false
                                onClicked: stackView.push("LearnMorePage.qml")
                            }
                        }
                    }
                }
            }
        }
    }
}
