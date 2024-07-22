// MainView.qml
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 1029
    height: 749
    title: "Bloodbound"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: LoginPage {}

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }
    }

    function showLoginScreen() {
        stackView.pop();
        stackView.push("LoginPage.qml");
    }
    function showWelcomeScreen(username, userType) {
        stackView.push("WelcomePage.qml", {"username": username, "userType": userType});
    }
    function showSignUpPage() {
        stackView.push("SignUpPage.qml");
    }
    function showResetPasswordPage() {
        stackView.push("PasswordResetPage.qml");
    }
}
