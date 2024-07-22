import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    id: donationWindow
    width: 500
    height: 600
    visible: true
    title: "Donation Form"

    property var healthQuestions: {
        "Diabetes": false,
        "Hepatitis": false,
        "HIV/AIDS": false
    }

    function submitDonation() {
        var isEligible = !healthQuestions["Diabetes"] && !healthQuestions["Hepatitis"] && !healthQuestions["HIV/AIDS"];

        if (isEligible) {
            console.log("Donation submitted for:", nameInput.text);
            console.log("Health conditions:", JSON.stringify(healthQuestions));
            console.log("Blood amount:", bloodAmountInput.text);
            donationWindow.close();
        } else {
            infoDialog.open();
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Text {
            text: "Donation Form"
            font.pixelSize: 24
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        TextField {
            id: nameInput
            placeholderText: "Enter your name"
            Layout.fillWidth: true
        }

        GroupBox {
            title: "Health Questions"
            Layout.fillWidth: true

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                CheckBox {
                    text: "Do you have Diabetes?"
                    onCheckedChanged: healthQuestions["Diabetes"] = checked
                }

                CheckBox {
                    text: "Do you have Hepatitis?"
                    onCheckedChanged: healthQuestions["Hepatitis"] = checked
                }

                CheckBox {
                    text: "Do you have HIV/AIDS?"
                    onCheckedChanged: healthQuestions["HIV/AIDS"] = checked
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Label {
                text: "Blood Amount (in ml):"
            }
            TextField {
                id: bloodAmountInput
                placeholderText: "Enter blood amount"
                validator: DoubleValidator {
                    bottom: 0
                    top: 1000
                    decimals: 2
                }
                Layout.fillWidth: true
            }
        }

        Button {
            text: "Submit"
            Layout.alignment: Qt.AlignHCenter
            onClicked: submitDonation()
        }
    }

    Dialog {
        id: infoDialog
        title: "Information"
        Text {
            text: "You are not eligible to donate blood due to your health conditions."
        }
        standardButtons: Dialog.Ok
    }
}
