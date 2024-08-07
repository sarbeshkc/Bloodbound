QT       += core gui quick qml sql
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    DatabaseManager.cpp \
    main.cpp

HEADERS += \
    DatabaseManager.h

FORMS +=

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    HospitalDashboardPage.qml \
    HospitalLoginPage.qml \
    HospitalSignupPage.qml \
    LearnMorePage.qml \
    LoginPage.qml \
    MainView.qml \
    MockData.qml \
    UserDashboardPage.qml \
    UserLoginPage.qml \
    UserSignupPage.qml

RESOURCES += \
    resources.qrc
