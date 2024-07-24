import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: learnMorePage

    property color primaryColor: "#FF5733"
    property color accentColor: "#4A90E2"

    background: Rectangle {
        color: "#f5f5f5"
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.3
            color: primaryColor

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20
                width: parent.width * 0.8

                Image {
                    source: "../../Pictures/Logo.png"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: Math.min(parent.width * 0.76, parent.height * 0.3)
                    Layout.preferredHeight: Layout.preferredWidth
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    text: "BloodBound"
                    font.pixelSize: Math.min(parent.width * 0.15, 36)
                    font.bold: true
                    color: "white"
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: "Learn More"
                    font.pixelSize: Math.min(parent.width * 0.08, 24)
                    color: "white"
                    opacity: 0.8
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }

        ScrollView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true

            ColumnLayout {
                width: parent.width * 0.9
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 30

                Text {
                    text: "Why Donate Blood?"
                    font.pixelSize: 24
                    font.bold: true
                    color: primaryColor
                    Layout.topMargin: 40
                }

                Text {
                    text: "Blood donation is a vital way to help save lives. When you donate blood, you're giving someone another chance at life. One donation can save up to three lives!"
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                    font.pixelSize: 16
                }

                Text {
                    text: "Who Can Donate?"
                    font.pixelSize: 24
                    font.bold: true
                    color: primaryColor
                }

                Text {
                    text: "In general, to donate blood you must be:\n• In good health\n• At least 17 years old in most states\n• Weigh at least 110 pounds\n• Have not donated blood in the last 56 days"
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                    font.pixelSize: 16
                }

                Text {
                    text: "The Donation Process"
                    font.pixelSize: 24
                    font.bold: true
                    color: primaryColor
                }

                Text {
                    text: "1. Registration\n2. Medical History and Mini-Physical\n3. Donation\n4. Refreshments and Rest"
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                    font.pixelSize: 16
                }

                Text {
                    text: "After Donating"
                    font.pixelSize: 24
                    font.bold: true
                    color: primaryColor
                }

                Text {
                    text: "• Drink extra fluids\n• Avoid strenuous physical activity or heavy lifting for about five hours\n• If you feel lightheaded, lie down with your feet up until the feeling passes"
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                    font.pixelSize: 16
                }

                Button {
                    text: "Back to Main Menu"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 250
                    Layout.preferredHeight: 50
                    font.pixelSize: 18
                    onClicked: stackView.pop()
                    background: Rectangle {
                        color: accentColor
                        radius: 25
                    }
                    contentItem: Text {
                        text: parent.text
                        font.bold: true
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Item {
                    Layout.fillHeight: true
                    Layout.minimumHeight: 40
                }
            }
        }
    }

    Text {
        text: "© 2024 BloodBound. All rights reserved."
        font.pixelSize: 12
        color: "#666666"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 10
        anchors.rightMargin: 20
    }
}
