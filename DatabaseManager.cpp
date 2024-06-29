#include "DatabaseManager.h"
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

DatabaseManager::DatabaseManager(QObject *parent)
    : QObject(parent)
{
    initializeDatabase();
}

bool DatabaseManager::insertUser(const QString &name, const QString &email, const QString &password)
{
    QSqlQuery query;
    query.prepare("INSERT INTO users (name, email, password) VALUES (:name, :email, :password)");
    query.bindValue(":name", name);
    query.bindValue(":email", email);
    query.bindValue(":password", password);

    if (query.exec()) {
        qDebug() << "User inserted successfully";
        return true;
    } else {
        qDebug() << "Error inserting user:" << query.lastError().text();
        return false;
    }
}

bool DatabaseManager::insertHospital(const QString &name, const QString &email, const QString &password)
{
    QSqlQuery query;
    query.prepare("INSERT INTO hospitals (name, email, password) VALUES (:name, :email, :password)");
    query.bindValue(":name", name);
    query.bindValue(":email", email);
    query.bindValue(":password", password);

    if (query.exec()) {
        qDebug() << "Hospital inserted successfully";
        return true;
    } else {
        qDebug() << "Error inserting hospital:" << query.lastError().text();
        return false;
    }
}

bool DatabaseManager::userLogin(const QString &email, const QString &password)
{
    QSqlQuery query;
    query.prepare("SELECT * FROM users WHERE email = :email AND password = :password");
    query.bindValue(":email", email);
    query.bindValue(":password", password);

    if (query.exec() && query.next()) {
        qDebug() << "User login successful";
        return true;
    } else {
        qDebug() << "User login failed";
        return false;
    }
}

bool DatabaseManager::hospitalLogin(const QString &email, const QString &password)
{
    QSqlQuery query;
    query.prepare("SELECT * FROM hospitals WHERE email = :email AND password = :password");
    query.bindValue(":email", email);
    query.bindValue(":password", password);

    if (query.exec() && query.next()) {
        qDebug() << "Hospital login successful";
        return true;
    } else {
        qDebug() << "Hospital login failed";
        return false;
    }
}

void DatabaseManager::initializeDatabase()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("bloodbank.db");

    if (db.open()) {
        qDebug() << "Database opened successfully";

        QSqlQuery query;
        query.exec("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT UNIQUE, password TEXT)");
        query.exec("CREATE TABLE IF NOT EXISTS hospitals (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT UNIQUE, password TEXT)");
    } else {
        qDebug() << "Error opening database:" << db.lastError().text();
    }
}
