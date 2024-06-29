import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.platform 1.1


Page {
    id: userSignupPage

    // Background image
    // Image {
    //     anchors.fill: parent
    //     source: "/home/satvara/Downloads/GIve_me_a_icon_for_a_app_called_bloodbound_and_it_should_be_related_to_donating_blood_png.png"
    //     fillMode: Image.PreserveAspectCrop
    //     opacity: 0.6
    // }

    property string selectedPhotoUrl: ""

    // Background overlay rectangle
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.5
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        width: 300


        Button {
                   text: "Select Photo"
                   Layout.fillWidth: true
                   font.pixelSize: 18
                   onClicked: {
                       fileDialog.open()
                   }
                   background: Rectangle {
                       color: "#FF5733"
                       radius: 5
                   }
               }

        Image {
               id: photoPreview
               source: selectedPhotoUrl
               fillMode: Image.PreserveAspectFit
               Layout.preferredWidth: 200
               Layout.preferredHeight: 200
               visible: selectedPhotoUrl !== ""
               Layout.alignment: Qt.AlignHCenter
           }

        // Name input
        TextField {
            id: nameInput
            placeholderText: "Name"
            Layout.fillWidth: true
             font.pixelSize: 18
             background: Rectangle {
                 color: "#FFFFFF"
                 radius: 5
                 border.color: nameInput.focus ? "#FF5733" : "#CCCCCC"
                 border.width: nameInput.focus ? 2 : 1
             }
             leftPadding: 10
             rightPadding: 10
             topPadding: 8
             bottomPadding: 8
             onFocusChanged: {
                 if (focus) {
                     color = "#333333"
                 } else {
                     color = "#666666"
                 }
             }
         }


        // Email input
        TextField {
            id: emailInput
            placeholderText: "Email"
            Layout.fillWidth: true
             font.pixelSize: 18
             background: Rectangle {
                 color: "#FFFFFF"
                 radius: 5
                 border.color: nameInput.focus ? "#FF5733" : "#CCCCCC"
                 border.width: nameInput.focus ? 2 : 1
             }
             leftPadding: 10
             rightPadding: 10
             topPadding: 8
             bottomPadding: 8
             onFocusChanged: {
                 if (focus) {
                     color = "#333333"
                 } else {
                     color = "#666666"
                 }
             }
         }

        // Password input
        TextField {
            id: passwordInput
            placeholderText: "Password"
            echoMode: TextInput.Password
            Layout.fillWidth: true
             font.pixelSize: 18
             background: Rectangle {
                 color: "#FFFFFF"
                 radius: 5
                 border.color: nameInput.focus ? "#FF5733" : "#CCCCCC"
                 border.width: nameInput.focus ? 2 : 1
             }
             leftPadding: 10
             rightPadding: 10
             topPadding: 8
             bottomPadding: 8
             onFocusChanged: {
                 if (focus) {
                     color = "#333333"
                 } else {
                     color = "#666666"
                 }
             }
         }

        // Confirm password input
        TextField {
            id: confirmPasswordInput
            placeholderText: "Confirm Password"
            echoMode: TextInput.Password
            Layout.fillWidth: true
             font.pixelSize: 18
             background: Rectangle {
                 color: "#FFFFFF"
                 radius: 5
                 border.color: nameInput.focus ? "#FF5733" : "#CCCCCC"
                 border.width: nameInput.focus ? 2 : 1
             }
             leftPadding: 10
             rightPadding: 10
             topPadding: 8
             bottomPadding: 8
             onFocusChanged: {
                 if (focus) {
                     color = "#333333"
                 } else {
                     color = "#666666"
                 }

           }
        }
        Button {
                  text: "Sign Up"
                  Layout.fillWidth: true
                  font.pixelSize: 18
                  onClicked: {
                      var name = nameInput.text;
                      var email = emailInput.text;
                      var password = passwordInput.text;
                      var confirmPassword = confirmPasswordInput.text;
                      var photoUrl = selectedPhotoUrl;

                      if (password === confirmPassword) {
                          var success = dbManager.insertUser(name, email, password, photoUrl);
                          if (success) {
                              console.log("User signup successful");
                              // Navigate to the user dashboard or login page
                              stackView.push("UserDashboardPage.qml");
                          } else {
                              console.log("User signup failed");
                              // Show an error message
                          }
                      } else {
                          console.log("Passwords do not match");
                          // Show an error message indicating that the passwords do not match
                      }
                  }



        }
        Text {
            text: "Back to Signup"
            color: "#FFFFFF"
            font.pixelSize: 16
            font.underline: true
            Layout.alignment: Qt.AlignHCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    // Navigate back to the main signup page
                    stackView.pop();
                }
            }

    }
    }

}
