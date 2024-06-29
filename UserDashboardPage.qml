import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    id: userDashboardPage

    property var userData: null

    Component.onCompleted: {
        // Fetch user data from the database
        userData = databaseManager.getUserData(email)
    }

    header: ToolBar {
        background: Rectangle {
            color: "#f2f2f2"
        }

        Label {
            text: "User Dashboard"
            font.pixelSize: 20
            anchors.centerIn: parent
        }
    }

    ScrollView {
        anchors.fill: parent

        ColumnLayout {
            width: parent.width
            spacing: 20

            Rectangle {
                Layout.fillWidth: true
                Layout.minimumHeight: 200
                color: "#e6e6e6"
                radius: 10

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20

                    Image {
                        id: profileImage
                        source: userData ? userData.profileImage : ""
                        fillMode: Image.PreserveAspectCrop
                        width: 100
                        height: 100
                        clip: true
                    }

                    ColumnLayout {
                        spacing: 10

                        Label {
                            text: userData ? userData.name : ""
                            font.pixelSize: 24
                            font.bold: true
                        }

                        Label {
                            text: userData ? userData.email : ""
                            font.pixelSize: 14
                            color: "#888"
                        }
                    }
                }
            }

            GridLayout {
                columns: 2
                rowSpacing: 10
                columnSpacing: 20
                Layout.fillWidth: true

                Label {
                    text: "Blood Group:"
                    font.bold: true
                }
                Label {
                    text: userData ? userData.bloodGroup : ""
                }

                Label {
                    text: "Contact Number:"
                    font.bold: true
                }
                Label {
                    text: userData ? userData.contactNumber : ""
                }

                // Add more user details as needed
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.minimumHeight: 200
                color: "#e6e6e6"
                radius: 10

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 10

                    Label {
                        text: "Comments"
                        font.pixelSize: 18
                        font.bold: true
                    }

                    TextArea {
                        id: commentInput
                        placeholderText: "Enter a comment..."
                        Layout.fillWidth: true
                    }

                    Button {
                        text: "Add Comment"
                        Layout.alignment: Qt.AlignRight
                        onClicked: {
                            // Add comment to the database
                            databaseManager.addUserComment(email, commentInput.text)
                            commentInput.clear()
                        }
                    }

                    ListView {
                        id: commentList
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: databaseManager.getUserComments(email)
                        delegate: CommentDelegate
                        clip: true
                    }
                }
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
}
