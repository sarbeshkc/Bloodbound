import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    id: hospitalSignupPage

    // Background image
    Image {
        anchors.fill: parent
        source: "/home/satvara/Downloads/GIve_me_a_icon_for_a_app_called_bloodbound_and_it_should_be_related_to_donating_blood_png.png"
        fillMode: Image.PreserveAspectCrop
        opacity: 0.6
    }

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

        // Name input
        TextField {
            id: nameInput
            placeholderText: "Hospital Name"
            Layout.fillWidth: true
             font.pixelSize: 18
             background: Rectangle {
                 color: "#FFFFFF"
                 radius: 5
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

        // Signup button
        Button {
            text: "Sign Up"
            Layout.fillWidth: true
            font.pixelSize: 18
            onClicked: {
                var name = nameInput.text;
                var email = emailInput.text;
                var password = passwordInput.text;
                var confirmPassword = confirmPasswordInput.text;

                if (password === confirmPassword) {
                    var success = dbManager.insertHospital(name, email, password);
                    if (success){
      donationPopup.open();                    } else {
                        console.log("Hospital signup failed");
                        // Show an error message

                    }
                } else {
                    console.log("Passwords do not match");
                }
            }
            background: Rectangle {
                color: "#FF5733"
                radius: 5
            }
        }


        // Blood donation registration pop-up
           Popup {
               id: donationPopup
               anchors.centerIn: parent
               modal: true
               focus: true
               // Background color of the pop-up
               background: Rectangle {
                   color: "#1E1E1E"  // Dark background color
                   radius: 5
               }

               // Blood donation registration form
               Column {
                   spacing: 20

                   // Registration title
                   Text {
                       text: qsTr("Blood Donation Registration")
                       font.pixelSize: 20
                       font.weight: Font.Bold
                       color: "white"
                       horizontalAlignment: Text.AlignHCenter
                   }

                   // Blood type input field
                   TextField {
                       id: bloodTypeField
                       width: parent.width
                       placeholderText: qsTr("Blood Type")
                       color: "white"
                       background: Rectangle {
                           color: "#333333"
                           radius: 5
                       }
                   }

                   // Last donation date input field
                   TextField {
                       id: lastDonationField
                       width: parent.width
                       placeholderText: qsTr("Last Donation Date (YYYY-MM-DD)")
                       color: "white"
                       background: Rectangle {
                           color: "#333333"
                           radius: 5
                       }
                   }

                   // Medical conditions input field
                   TextField {
                       id: medicalConditionsField
                       width: parent.width
                       placeholderText: qsTr("Medical Conditions (if any)")
                       color: "white"
                       background: Rectangle {
                           color: "#333333"
                           radius: 5
                       }
                   }

                   // Registration button
                   Button {
                       width: parent.width
                       text: qsTr("Register")
                       font.pixelSize: 18
                       onClicked: {
                           // Get the entered values from input fields
                           var bloodType = bloodTypeField.text;
                           var lastDonation = lastDonationField.text;
                           var medicalConditions = medicalConditionsField.text;

                           // Get the user ID of the last inserted user
                           var userId = getLastUserId();
                           if (userId !== -1) {

                           }else {
                               console.log("Failed to get user ID");
                           }

                           // Close the pop-up after registration
                           donationPopup.close();
                       }
                       background: Rectangle {
                           color: "#FF5733"
                           radius: 5
                       }
              }   }  }








        // Back to main signup page link
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