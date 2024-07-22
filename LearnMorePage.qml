// LearnMorePage.qml
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    id: learnMorePage

    background: Rectangle {
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#4A90E2" }
            GradientStop { position: 1.0; color: "#FFFFFF" }
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: parent.width
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 20

            Text {
                text: "Learn More About Blood Donation"
                font.pixelSize: 24
                font.bold: true
                color: "#FFFFFF"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "Why Donate Blood?"
                font.pixelSize: 20
                font.bold: true
                color: "#FF5733"
            }

            Text {
                text: "Blood donation is a vital way to help save lives. When you donate blood, you're giving someone another chance at life. One donation can save up to three lives!"
                wrapMode: Text.Wrap
                Layout.fillWidth: true
            }

            Text {
                text: "Who Can Donate?"
                font.pixelSize: 20
                font.bold: true
                color: "#FF5733"
            }

            Text {
                text: "In general, to donate blood you must be:\n• In good health\n• At least 17 years old in most states\n• Weigh at least 110 pounds\n• Have not donated blood in the last 56 days"
                wrapMode: Text.Wrap
                Layout.fillWidth: true
            }

            Text {
                text: "The Donation Process"
                font.pixelSize: 20
                font.bold: true
                color: "#FF5733"
            }

            Text {
                text: "1. Registration\n2. Medical History and Mini-Physical\n3. Donation\n4. Refreshments and Rest"
                wrapMode: Text.Wrap
                Layout.fillWidth: true
            }

            Text {
                text: "After Donating"
                font.pixelSize: 20
                font.bold: true
                color: "#FF5733"
            }

            Text {
                text: "• Drink extra fluids\n• Avoid strenuous physical activity or heavy lifting for about five hours\n• If you feel lightheaded, lie down with your feet up until the feeling passes"
                wrapMode: Text.Wrap
                Layout.fillWidth: true
            }

            Button {
                text: "Back to Sign Up"
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    stackView.pop();
                }
                background: Rectangle {
                    color: "#4CAF50"
                    radius: 5
                }
            }
        }
    }
}
