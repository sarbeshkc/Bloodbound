#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QVariantMap>
#include <QVariantList>
#include <QDateTime>

class DatabaseManager : public QObject
{
    Q_OBJECT

public:
    explicit DatabaseManager(QObject *parent = nullptr);

    // User management
  Q_INVOKABLE  bool insertUser(const QString &name, const QString &email, const QString &password, const QString &bloodGroup, const QString &healthInfo);
   Q_INVOKABLE bool userLogin(const QString &email, const QString &password);
  Q_INVOKABLE  QVariantMap getUserData(const QString &email);
     Q_INVOKABLE bool updateUserProfile(const QString &email, const QVariantMap &userData);
   Q_INVOKABLE bool changeUserPassword(const QString &email, const QString &oldPassword, const QString &newPassword);
  Q_INVOKABLE bool deleteUser(const QString &email, const QString &password);

    // Hospital management
 Q_INVOKABLE bool insertHospital(const QString &name, const QString &email, const QString &password,
                                    const QString &contactNumber, const QString &address, const QString &city,
                                    const QString &state, const QString &country, const QString &zip,
                                    const QString &license);
  Q_INVOKABLE bool hospitalLogin(const QString &email, const QString &password);


   Q_INVOKABLE QVariantMap getHospitalData(const QString &email);
   Q_INVOKABLE bool updateHospitalProfile(const QString &email, const QVariantMap &hospitalData);
   Q_INVOKABLE bool changeHospitalPassword(const QString &email, const QString &oldPassword, const QString &newPassword);
   Q_INVOKABLE bool deleteHospital(const QString &email, const QString &password);
   Q_INVOKABLE QVariantList getHospitalList();

    // Donation management
    void donateUser(const QString &email, double bloodAmount);
   Q_INVOKABLE QVariantList getUserDonationHistory(const QString &email);
   Q_INVOKABLE QVariantList getRecentDonations(int limit);
   Q_INVOKABLE QVariantMap getBloodInventory();

    // Comment management
   Q_INVOKABLE QVariantList getUserComments(const QString &email);
   Q_INVOKABLE bool addUserComment(const QString &email, const QString &commentText);

    // Donor search
   Q_INVOKABLE QVariantList searchDonors(const QString &bloodGroup, const QString &location);

    // Appointment management
 Q_INVOKABLE   bool scheduleAppointment(const QString &userEmail, const QString &hospitalEmail, const QDateTime &appointmentDate);
   Q_INVOKABLE QVariantList getUserAppointments(const QString &userEmail);
   Q_INVOKABLE QVariantList getHospitalAppointments(const QString &hospitalEmail);

private:
    QSqlDatabase m_database;
    void initializeDatabase();
    void createTables();
    QString hashPassword(const QString &password);
};

#endif // DATABASEMANAGER_H
