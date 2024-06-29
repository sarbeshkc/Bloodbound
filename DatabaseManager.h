#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>

class DatabaseManager : public QObject
{
    Q_OBJECT

public:
    explicit DatabaseManager(QObject *parent = nullptr);

    Q_INVOKABLE bool insertUser(const QString &name, const QString &email, const QString &password);
    Q_INVOKABLE bool insertHospital(const QString &name, const QString &email, const QString &password);
    Q_INVOKABLE bool userLogin(const QString &email, const QString &password);
    Q_INVOKABLE bool hospitalLogin(const QString &email, const QString &password);

private:
    void initializeDatabase();
};

#endif // DATABASEMANAGER_H
