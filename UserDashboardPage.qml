import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs

Page {
    id: userDashboardPage

    property string userEmail: ""
    property var userData: null
    property int currentSection: 0

    // Use the mock data from the external file
    property var nearestHospitals: MockDataImport.MockData.nearestHospitals

    Component.onCompleted: {
        userData = dbManager.getUserData(userEmail)
    }

    Rectangle {
        anchors.fill: parent
        color: "#ffffff"  // White background

        RowLayout {
            anchors.fill: parent
            spacing: 0

            // Side Navigation Bar
            Rectangle {
                Layout.preferredWidth: 240
                Layout.fillHeight: true
                color: "#4A90E2"  // Blue sidebar color

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 0

                    Rectangle {
                        Layout.fillWidth: true
                        height: 60
                        color: "#4A90E2"  // Darker blue for header

                        Label {
                            anchors.centerIn: parent
                            text: "BloodBound"
                            font.pixelSize: 20
                            font.bold: true
                            color: "white"
                        }
                    }

                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: ["Dashboard", "Donation History", "Settings"]
                        delegate: ItemDelegate {
                            width: parent.width
                            height: 48
                            highlighted: index === currentSection

                            contentItem: RowLayout {
                                spacing: 16

                                Rectangle {
                                    width: 4
                                    height: parent.height
                                    color: parent.parent.highlighted ? "#ffffff" : "transparent"
                                    visible: parent.parent.highlighted
                                }

                                Label {
                                    text: modelData
                                    color: parent.parent.highlighted ? "#ffffff" : "#E3F2FD"
                                    font.pixelSize: 16
                                }
                            }

                            background: Rectangle {
                                color: parent.highlighted ? "#1E88E5" : "transparent"
                            }

                            onClicked: currentSection = index
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        height: 60
                        color: "#4A90E2"  // Darker blue for user area

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 12

                            Rectangle {
                                width: 36
                                height: 36
                                radius: 18
                                color: "#E3F2FD"

                                Label {
                                    anchors.centerIn: parent
                                    text: userData ? userData.name[0].toUpperCase() : ""
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "#4A90E2"
                                }
                            }

                            Label {
                                text: userData ? userData.name : ""
                                color: "white"
                                font.pixelSize: 16
                            }

                            Item { Layout.fillWidth: true }

                            Button {
                                text: "Logout"
                                onClicked: {
                                    // Implement logout functionality
                                    stackView.pop()
                                }
                                background: Rectangle {
                                    color: "#E3F2FD"
                                    radius: 4
                                }
                                contentItem: Text {
                                    text: parent.text
                                    color: "#4A90E2"
                                    font.pixelSize: 14
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }
                    }
                }
            }

            // Main Content Area
            StackLayout {
                currentIndex: currentSection
                Layout.fillWidth: true
                Layout.fillHeight: true

                // Dashboard Section
                ScrollView {
                    clip: true
                    contentWidth: availableWidth

                    ColumnLayout {
                        width: parent.width
                        spacing: 24

                        DashboardHeader {
                            Layout.fillWidth: true
                            userName: userData ? userData.name : ""
                            userBloodGroup: userData ? userData.bloodGroup : ""
                        }

                        DashboardSection {
                            title: "Quick Stats"
                            content: GridLayout {
                                columns: 3
                                columnSpacing: 16
                                rowSpacing: 16

                                Repeater {
                                    model: [
                                        { label: "Total Donations", value: dbManager.getUserTotalDonations(userEmail) },
                                        { label: "Last Donation", value: userData && userData.lastDonation ? userData.lastDonation : "N/A" },
                                        { label: "Lives Saved", value: Math.floor(dbManager.getUserTotalDonations(userEmail) / 500) }
                                    ]
                                    delegate: Rectangle {
                                        Layout.fillWidth: true
                                        height: 100
                                        color: "#E3F2FD"
                                        radius: 8

                                        ColumnLayout {
                                            anchors.centerIn: parent
                                            spacing: 8

                                            Label {
                                                text: modelData.label
                                                color: "#2962FF"
                                                font.pixelSize: 16
                                                font.bold: true
                                            }
                                            Label {
                                                text: modelData.value
                                                color: "#1E4BFF"
                                                font.pixelSize: 28
                                                font.bold: true
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        DashboardSection {
                            title: "Upcoming Appointments"
                            content: ListView {
                                implicitHeight: 200
                                model: dbManager.getUserUpcomingAppointments(userEmail)
                                delegate: ItemDelegate {
                                    width: parent.width
                                    height: 72

                                    background: Rectangle {
                                        color: "#E3F2FD"
                                        radius: 8
                                    }

                                    contentItem: RowLayout {
                                        spacing: 16

                                        ColumnLayout {
                                            spacing: 8

                                            Label {
                                                text: modelData.date
                                                color: "#1E4BFF"
                                                font.bold: true
                                            }
                                            Label {
                                                text: modelData.hospitalName
                                                color: "#2962FF"
                                            }
                                        }

                                        Item { Layout.fillWidth: true }

                                        Button {
                                            text: "Cancel"
                                            onClicked: cancelAppointment(modelData.id)
                                            background: Rectangle {
                                                color: "#FF1744"
                                                radius: 4
                                            }
                                            contentItem: Text {
                                                text: parent.text
                                                color: "white"
                                                font.pixelSize: 14
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                // Donation History Section
                ScrollView {
                    clip: true
                    contentWidth: availableWidth

                    ColumnLayout {
                        width: parent.width
                        spacing: 24

                        DashboardSection {
                            title: "Donation History"
                            content: ListView {
                                implicitHeight: 400
                                model: dbManager.getUserDonationHistory(userEmail)
                                delegate: ItemDelegate {
                                    width: parent.width
                                    height: 72

                                    background: Rectangle {
                                        color: "#E3F2FD"
                                        radius: 8
                                    }

                                    contentItem: RowLayout {
                                        spacing: 16

                                        ColumnLayout {
                                            spacing: 8

                                            Label {
                                                text: modelData.date
                                                color: "#1E4BFF"
                                                font.bold: true
                                            }
                                            Label {
                                                text: modelData.hospitalName
                                                color: "#2962FF"
                                            }
                                        }

                                        Item { Layout.fillWidth: true }

                                        Label {
                                            text: modelData.amount + " ml"
                                            color: "#2962FF"
                                            font.bold: true
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                // Settings Section
                ScrollView {
                    clip: true
                    contentWidth: availableWidth

                    ColumnLayout {
                        width: parent.width
                        spacing: 24

                        DashboardSection {
                            title: "Account Settings"
                            content: ColumnLayout {
                                spacing: 16

                                TextField {
                                    id: nameInput
                                    Layout.fillWidth: true
                                    placeholderText: "Full Name"
                                    text: userData ? userData.name : ""
                                    color: "#1E4BFF"
                                    background: Rectangle {
                                        color: "#E3F2FD"
                                        radius: 4
                                    }
                                }

                                Button {
                                    text: "Update Name"
                                    onClicked: updateName()
                                    background: Rectangle {
                                        color: "#2962FF"
                                        radius: 4
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "white"
                                        font.pixelSize: 16
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                }

                                Button {
                                    text: "Change Password"
                                    onClicked: changePasswordDialog.open()
                                    background: Rectangle {
                                        color: "#2962FF"
                                        radius: 4
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "white"
                                        font.pixelSize: 16
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                }

                                Button {
                                    text: "Delete Account"
                                    onClicked: deleteAccountDialog.open()
                                    background: Rectangle {
                                        color: "#FF1744"
                                        radius: 4
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "white"
                                        font.pixelSize: 16
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Dialogs
    Dialog {
        id: changePasswordDialog
        title: "Change Password"
        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted: changePassword()

        background: Rectangle {
            color: "#ffffff"
            border.color: "#2962FF"
            border.width: 1
            radius: 8
        }

        ColumnLayout {
            spacing: 16

            TextField {
                id: currentPasswordInput
                Layout.fillWidth: true
                placeholderText: "Current Password"
                echoMode: TextInput.Password
                color: "#1E4BFF"
                background: Rectangle {
                    color: "#E3F2FD"
                    radius: 4
                }
            }
            TextField {
                id: newPasswordInput
                Layout.fillWidth: true
                placeholderText: "New Password"
                echoMode: TextInput.Password
                color: "#1E4BFF"
                background: Rectangle {
                    color: "#E3F2FD"
                    radius: 4
                }
            }
            TextField {
                id: confirmNewPasswordInput
                Layout.fillWidth: true
                placeholderText: "Confirm New Password"
                echoMode: TextInput.Password
                color: "#1E4BFF"
                background: Rectangle {
                    color: "#E3F2FD"
                    radius: 4
                }
            }
        }
    }

    Dialog {
        id: deleteAccountDialog
        title: "Delete Account"
        standardButtons: Dialog.Yes | Dialog.No
        onAccepted: deleteAccount()

        background: Rectangle {
            color: "#ffffff"
            border.color: "#FF1744"
            border.width: 1
            radius: 8
        }

        ColumnLayout {
            spacing: 16

            Label {
                text: "Are you sure you want to delete your account? This action cannot be undone."
                color: "#1E4BFF"
                wrapMode: Text.Wrap
            }

            TextField {
                id: deleteAccountPasswordInput
                Layout.fillWidth: true
                placeholderText: "Enter your password to confirm"
                echoMode: TextInput.Password
                color: "#1E4BFF"
                background: Rectangle {
                    color: "#E3F2FD"
                    radius: 4
                }
            }
        }
    }

    Dialog {
        id: bookAppointmentDialog
        title: "Book Donation Appointment"
        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted: bookAppointment()

        background: Rectangle {
            color: "#ffffff"
            border.color: "#2962FF"
            border.width: 1
            radius: 8
        }

        ColumnLayout {
            spacing: 16
            width: 300

            Label {
                text: "Select a Hospital"
                font.bold: true
                color: "#1E4BFF"
            }

            ListView {
                Layout.fillWidth: true
                height: 150
                clip: true
                model: nearestHospitals
                delegate: ItemDelegate {
                    width: parent.width
                    height: 60

                    onClicked: {
                        hospitalSelect.currentIndex = index
                        hospitalSelect.displayText = modelData.name
                    }

                    contentItem: ColumnLayout {
                        spacing: 8

                        Label {
                            text: modelData.name
                            color: "#1E4BFF"
                            font.bold: true
                        }
                        Label {
                            text: modelData.distance
                            color: "#2962FF"
                        }
                    }
                }
            }

            ComboBox {
                id: hospitalSelect
                Layout.fillWidth: true
                model: nearestHospitals
                textRole: "name"
                valueRole: "email"
                displayText: "Select a hospital"
                }

            RowLayout {
                        Layout.fillWidth: true
                        spacing: 16

                        CheckBox {
                            id: healthyCheckbox
                            text: "I am healthy and able to donate"
                            checked: false
                        }

                        CheckBox {
                            id: medicationCheckbox
                            text: "I am not on any medication"
                            checked: false
                        }

                        CheckBox {
                            id: recentIllnessCheckbox
                            text: "I have not been ill recently"
                            checked: false
                        }
                    }

                    TextField {
                        id: appointmentDateInput
                        Layout.fillWidth: true
                        placeholderText: "Appointment Date (YYYY-MM-DD)"
                        color: "#1E4BFF"
                        background: Rectangle {
                            color: "#E3F2FD"
                            radius: 4
                        }
                    }
                }
            }

            // Components
            component DashboardHeader: Rectangle {
                height: 120
                color: "#2962FF"

                property string userName: ""
                property string userBloodGroup: ""

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 24
                    spacing: 24

                    ColumnLayout {
                        spacing: 8

                        Label {
                            text: "Welcome, " + userName
                            font.pixelSize: 28
                            font.bold: true
                            color: "white"
                        }
                        Label {
                            text: "Blood Group: " + userBloodGroup
                            font.pixelSize: 18
                            color: "#E3F2FD"
                        }
                    }

                    Item { Layout.fillWidth: true }

                    Button {
                        text: "Book Donation"
                        onClicked: {
                            if (canDonate()) {
                                bookAppointmentDialog.open()
                            } else {
                                showMessage("You are not eligible to donate at this time. Please wait at least 3 months between donations.")
                            }
                        }
                        background: Rectangle {
                            color: "#E3F2FD"
                            radius: 4
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "#2962FF"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            component DashboardSection: ColumnLayout {
                Layout.fillWidth: true
                spacing: 16

                property string title
                property var content

                Label {
                    text: title
                    font.pixelSize: 20
                    font.bold: true
                    color: "#1E4BFF"
                }

                Loader {
                    Layout.fillWidth: true
                    sourceComponent: content
                }
            }

            // Functions
            function changePassword() {
                if (newPasswordInput.text === confirmNewPasswordInput.text) {
                    var success = dbManager.changeUserPassword(userEmail, currentPasswordInput.text, newPasswordInput.text)
                    if (success) {
                        showMessage("Password changed successfully")
                        changePasswordDialog.close()
                    } else {
                        showError("Failed to change password. Please check your current password.")
                    }
                } else {
                    showError("New passwords do not match")
                }
            }

            function updateName() {
                var success = dbManager.updateUserProfile(userEmail, { name: nameInput.text })
                if (success) {
                    userData.name = nameInput.text
                    showMessage("Name updated successfully")
                } else {
                    showError("Failed to update name")
                }
            }

            function deleteAccount() {
                var success = dbManager.deleteUser(userEmail, deleteAccountPasswordInput.text)
                if (success) {
                    showMessage("Account deleted successfully")
                    stackView.pop()
                } else {
                    showError("Failed to delete account. Please check your password.")
                }
            }

            function canDonate() {
                if (!userData || !userData.lastDonation) return true
                var lastDonationDate = new Date(userData.lastDonation)
                var currentDate = new Date()
                var monthsDiff = (currentDate.getFullYear() - lastDonationDate.getFullYear()) * 12 +
                                 (currentDate.getMonth() - lastDonationDate.getMonth())
                return monthsDiff >= 3
            }

            function bookAppointment() {
                if (!healthyCheckbox.checked || !medicationCheckbox.checked || !recentIllnessCheckbox.checked) {
                    showError("You must meet all health requirements to donate blood.")
                    return
                }

                var hospitalEmail = hospitalSelect.currentValue
                var appointmentDate = new Date(appointmentDateInput.text)

                var success = dbManager.scheduleAppointment(userEmail, hospitalEmail, appointmentDate)
                if (success) {
                    showMessage("Appointment booked successfully")
                    bookAppointmentDialog.close()
                } else {
                    showError("Failed to book appointment")
                }
            }

            function cancelAppointment(appointmentId) {
                var success = dbManager.cancelAppointment(appointmentId)
                if (success) {
                    showMessage("Appointment cancelled successfully")
                    // Refresh the appointments list
                    var upcomingAppointments = dbManager.getUserUpcomingAppointments(userEmail)
                    // Update the model of the ListView showing upcoming appointments
                } else {
                    showError("Failed to cancel appointment")
                }
            }

            function showMessage(message) {
                messageDialog.text = message
                messageDialog.open()
            }

            function showError(message) {
                errorDialog.text = message
                errorDialog.open()
            }

            Dialog {
                id: messageDialog
                title: "Message"
                standardButtons: Dialog.Ok

                background: Rectangle {
                    color: "#ffffff"
                    border.color: "#2962FF"
                    border.width: 1
                    radius: 8
                }

                Label {
                    text: messageDialog.text
                    color: "#1E4BFF"
                    wrapMode: Text.Wrap
                }
            }

            Dialog {
                id: errorDialog
                title: "Error"
                standardButtons: Dialog.Ok

                background: Rectangle {
                    color: "#ffffff"
                    border.color: "#FF1744"
                    border.width: 1
                    radius: 8
                }

                Label {
                    text: errorDialog.text
                    color: "#FF1744"
                    wrapMode: Text.Wrap
                }
            }
}
