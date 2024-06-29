import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    id: loginPage

    // Background image
    Image {
        anchors.fill: parent
        source: "/home/satvara/Downloads/backgroundd.png"
        fillMode: Image.PreserveAspectCrop
        opacity: 0.6
    }

    // Background overlay rectangle

    Item {
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.top: parent.top
          anchors.topMargin: parent.height * 0.2  // Adjust the top margin as needed
          width: parent.width * 0.8
          height: welcomeText.height

          // Welcome text
          Text {
              id: welcomeText
              anchors.centerIn: parent
              text: qsTr("Welcome to Bloodbound")
              font.pixelSize: 48
              font.family: "Arial"
              font.weight: Font.Bold
              color: "white"
              style: Text.Outline
              styleColor: "#FF5733"  // Outline color
              horizontalAlignment: Text.AlignHCenter
              verticalAlignment: Text.AlignVCenter

          }
      }

    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.5
    }


    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        width: 300

        // User login button
        Button {
            text: "User Login"
            Layout.fillWidth: true
            font.pixelSize: 18
            onClicked: {
                stackView.push("UserLoginPage.qml");
            }
            background: Rectangle {
                color: "#FF5733"
                radius: 5
            }
        }

        // Hospital login button
        Button {
            text: "Hospital Login"
            Layout.fillWidth: true
            font.pixelSize: 18
            onClicked: {
                stackView.push("HospitalLoginPage.qml");
            }
            background: Rectangle {
                color: "#FF5733"
                radius: 5
            }
        }

        // Signup link
        Text {
            text: "Sign Up"
            color: "#FFFFFF"
            font.pixelSize: 16
            font.underline: true
            Layout.alignment: Qt.AlignHCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    // Navigate to the signup page
                    stackView.push("SignUpPage.qml");
                }
            }
        }
    }
}
