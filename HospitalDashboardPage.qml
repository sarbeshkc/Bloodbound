import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    id: hospitalDashboardPage

    property var hospitalData: null

    Component.onCompleted: {
        // Fetch hospital data from the database
        hospitalData = databaseManager.getHospitalData(email)
    }

    header: ToolBar {
        Label {
            text: "Hospital Dashboard"
            font.pixelSize: 20
            anchors.centerIn: parent
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        Image {
            id: profileImage
            source: hospitalData ? hospitalData.profileImage : ""
            Layout.alignment: Qt.AlignHCenter
            fillMode: Image.PreserveAspectCrop
            width: 100
            height: 100
            clip: true
        }

        Label {
            text: hospitalData ? hospitalData.name : ""
            font.pixelSize: 24
            Layout.alignment: Qt.AlignHCenter
        }

        GridLayout {
            columns: 2
            rowSpacing: 10
            columnSpacing: 10
            Layout.alignment: Qt.AlignCenter

            Label { text: "Email:" }
            Label { text: hospitalData ? hospitalData.email : "" }

            Label { text: "Address:" }
            Label { text: hospitalData ? hospitalData.address : "" }

            Label { text: "Contact Number:" }
            Label { text: hospitalData ? hospitalData.contactNumber : "" }

            // Add more hospital details as needed
        }

        TextArea {
            id: commentInput
            placeholderText: "Enter a comment..."
            Layout.fillWidth: true
        }

        Button {
            text: "Add Comment"
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                // Add comment to the database
                databaseManager.addHospitalComment(email, commentInput.text)
                commentInput.clear()
            }
        }

        ListView {
            id: commentList
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: databaseManager.getHospitalComments(email)
            delegate: CommentDelegate
        }

        Button {
            text: "Logout"
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                // Perform logout action and navigate back to login page
                stackView.pop()
            }
        }
    }
}
