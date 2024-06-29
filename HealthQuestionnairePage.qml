// HealthQuestionnairePage.qml
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    id: healthQuestionnairePage

    property string userEmail: ""

    // Background rectangle with opacity
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.7
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        // Question 1
        Text {
            text: "Question 1: How often do you exercise?"
            color: "#FFFFFF"
            font.pixelSize: 18
        }
        TextField {
            id: question1Input
            placeholderText: "Enter your answer"
            Layout.fillWidth: true
            background: Rectangle {
                color: "#FFFFFF"
                radius: 5
            }
        }

        // Question 2
        Text {
            text: "Question 2: Do you have any chronic health conditions?"
            color: "#FFFFFF"
            font.pixelSize: 18
        }
        TextField {
            id: question2Input
            placeholderText: "Enter your answer"
            Layout.fillWidth: true
            background: Rectangle {
                color: "#FFFFFF"
                radius: 5
            }
        }

        // Submit button
        Button {
            text: "Submit"
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                // Store health info in the database
                dbManager.insertHealthInfo(userEmail, "Question 1", question1Input.text);
                dbManager.insertHealthInfo(userEmail, "Question 2", question2Input.text);
                // Navigate to the user dashboard or any other relevant page
                mainWindow.showUserDashboardPage(userEmail);
            }
            background: Rectangle {
                color: "#FF5733"
                radius: 5
            }
        }
    }
}
