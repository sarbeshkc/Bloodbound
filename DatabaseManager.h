#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include<QSql>
#include<QSqlDatabase>

class DatabaseManager : public QObject
{
    Q_OBJECT

public:
    explicit DatabaseManager(QObject *parent = nullptr);

    Q_INVOKABLE bool insertUser(const QString &name, const QString &email, const QString &password);
    Q_INVOKABLE bool insertHospital(const QString &name, const QString &email, const QString &password);
    Q_INVOKABLE bool userLogin(const QString &email, const QString &password);
    Q_INVOKABLE bool hospitalLogin(const QString &email, const QString &password);
    Q_INVOKABLE void donateUser(const QString &name, int diabetes, int hepatitis, int hivAids, double bloodAmount);
    // Q_INVOKABLE bool checkEligibility(const QVariantMap &healthAnswers);
    QVariantMap getHospitalData(const QString &email);
    bool addHospitalComment(const QString &hospitalEmail, const QString &comment);
    QVariantList getHospitalComments(const QString &hospitalEmail);
    Q_INVOKABLE int getLastUserID();



private:
    QSqlDatabase m_database;

    void initializeDatabase();
};

#endif // DATABASEMANAGER_H
