import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: hospitalDashboardPage

    property string hospitalEmail: ""
    property var hospitalData: null

    Component.onCompleted: {
        hospitalData = dbManager.getHospitalData(hospitalEmail)
    }

    background: Rectangle {
        color: "#36393F"  // Discord-like dark background
    }

    header: ToolBar {
        background: Rectangle {
            color: "#202225"  // Discord-like darker top bar
        }
        RowLayout {
            anchors.fill: parent
            spacing: 10

            Label {
                text: "BloodBound"
                font.pixelSize: 20
                font.bold: true
                color: "#FFFFFF"
                Layout.alignment: Qt.AlignLeft
                Layout.leftMargin: 10
            }

            Rectangle {
                Layout.fillWidth: true
                height: 30
                color: "#40444B"  // Discord-like search bar color
                radius: 4

                TextField {
                    anchors.fill: parent
                    placeholderText: "Search"
                    color: "#FFFFFF"
                    font.pixelSize: 14
                    leftPadding: 30
                    background: Item {}

                    Text {
                        text: "🔍"  // Unicode search icon
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 8
                        font.pixelSize: 16
                        color: "#B9BBBE"
                    }
                }
            }

            ToolButton {
                text: "Logout"
                font.pixelSize: 14
                onClicked: stackView.pop()
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: "#FFFFFF"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    color: parent.hovered ? "#4F545C" : "transparent"
                    radius: 4
                }
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // Left sidebar
        Rectangle {
            Layout.preferredWidth: 240
            Layout.fillHeight: true
            color: "#2F3136"  // Discord-like sidebar color

            ColumnLayout {
                anchors.fill: parent
                spacing: 20

                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 120
                    Layout.preferredHeight: 120
                    radius: 60
                    color: "#40444B"

                    Text {
                        anchors.centerIn: parent
                        text: hospitalData ? hospitalData.name.charAt(0).toUpperCase() : "H"
                        font.pixelSize: 60
                        color: "#FFFFFF"
                    }
                }

                Label {
                    text: hospitalData ? hospitalData.name : ""
                    font.pixelSize: 18
                    font.bold: true
                    color: "#FFFFFF"
                    Layout.alignment: Qt.AlignHCenter
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: "#40444B"
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.leftMargin: 20
                    Layout.rightMargin: 20
                    spacing: 10

                    Label { text: "Email:"; font.bold: true; color: "#B9BBBE" }
                    Label { text: hospitalData ? hospitalData.email : ""; color: "#FFFFFF"; wrapMode: Text.Wrap }

                    Label { text: "Address:"; font.bold: true; color: "#B9BBBE" }
                    Label { text: hospitalData ? hospitalData.address : ""; color: "#FFFFFF"; wrapMode: Text.Wrap }

                    Label { text: "Contact:"; font.bold: true; color: "#B9BBBE" }
                    Label { text: hospitalData ? hospitalData.contactNumber : ""; color: "#FFFFFF" }
                }
            }
        }

        // Main content area
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ColumnLayout {
                width: parent.width
                spacing: 20

                // Appointments section
                DashboardSection {
                    title: "Upcoming Appointments"
                    Layout.fillWidth: true
                    Layout.margins: 20

                    content: ListView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 200
                        model: dbManager.getHospitalAppointments(hospitalEmail)
                        delegate: ItemDelegate {
                            width: parent.width
                            height: 40
                            contentItem: RowLayout {
                                spacing: 10
                                Label { text: modelData.date.toLocaleDateString(); font.bold: true; color: "#FFFFFF" }
                                Label { text: modelData.userName; color: "#FFFFFF" }
                                Label { text: "Blood Group: " + modelData.bloodGroup; color: "#FFFFFF" }
                            }
                            background: Rectangle {
                                color: parent.hovered ? "#40444B" : "transparent"
                            }
                        }
                    }
                }

                // Blood Inventory section
                DashboardSection {
                    title: "Blood Inventory"
                    Layout.fillWidth: true
                    Layout.margins: 20

                    content: GridLayout {
                        columns: 4
                        rowSpacing: 10
                        columnSpacing: 20
                        Layout.fillWidth: true

                        Repeater {
                            model: ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]
                            delegate: ColumnLayout {
                                Label {
                                    text: modelData
                                    font.bold: true
                                    color: "#FFFFFF"
                                    Layout.alignment: Qt.AlignHCenter
                                }
                                Label {
                                    text: dbManager.getBloodInventory()[modelData] + " ml"
                                    color: "#B9BBBE"
                                    Layout.alignment: Qt.AlignHCenter
                                }
                            }
                        }
                    }
                }

                // Recent Donations section
                DashboardSection {
                    title: "Recent Donations"
                    Layout.fillWidth: true
                    Layout.margins: 20

                    content: ListView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 200
                        model: dbManager.getRecentDonations(10)
                        delegate: ItemDelegate {
                            width: parent.width
                            height: 40
                            contentItem: RowLayout {
                                spacing: 10
                                Label { text: modelData.date; font.bold: true; color: "#FFFFFF" }
                                Label { text: modelData.name; color: "#FFFFFF" }
                                Label { text: modelData.bloodGroup; color: "#FFFFFF" }
                                Label { text: modelData.amount + " ml"; color: "#FFFFFF" }
                            }
                            background: Rectangle {
                                color: parent.hovered ? "#40444B" : "transparent"
                            }
                        }
                    }
                }
            }
        }
    }

    // Custom component for dashboard sections
    component DashboardSection: ColumnLayout {
        property string title
        property alias content: contentLoader.sourceComponent

        spacing: 10

        Label {
            text: title
            font.pixelSize: 18
            font.bold: true
            color: "#FFFFFF"
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#40444B"
        }

        Loader {
            id: contentLoader
            Layout.fillWidth: true
        }
    }
}
