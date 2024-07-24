#include "DatabaseManager.h"
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QDateTime>

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
void DatabaseManager::donateUser(const QString &name, int diabetes, int hepatitis, int hivAids, double bloodAmount)
{
    QSqlQuery query;

    // Check if the user is eligible to donate based on health answers
    bool isEligible = (diabetes < 3 && hepatitis < 3 && hivAids < 3);

    if (isEligible) {
        // Prepare the SQL query to insert the user's donation information
        query.prepare("INSERT INTO blood_donation (user_id, donation_date, diabetes, hepatitis, hiv_aids, blood_amount) VALUES ((SELECT id FROM users WHERE name = :name), :donation_date, :diabetes, :hepatitis, :hiv_aids, :blood_amount)");
        query.bindValue(":name", name);
        query.bindValue(":donation_date", QDateTime::currentDateTime());
        query.bindValue(":diabetes", diabetes);
        query.bindValue(":hepatitis", hepatitis);
        query.bindValue(":hiv_aids", hivAids);
        query.bindValue(":blood_amount", bloodAmount);

        // Execute the query
        if (!query.exec()) {
            qDebug() << "Error inserting donation record:" << query.lastError().text();
        }
    } else {
        qDebug() << "User is not eligible to donate blood.";
    }
}

// bool DatabaseManager::checkEligibility(const QVariantMap &healthAnswers)
// {
//     // Define the severity levels for each health condition
//     QMap<QString, int> severityLevels = {
//         {"Diabetes", 2},
//         {"Hepatitis", 3},
//         {"HIV/AIDS", 3},
//         // Add more health conditions and their severity levels here
//     };

//     // Check the user's health answers against the severity levels
//     for (auto it = healthAnswers.constBegin(); it != healthAnswers.constEnd(); ++it) {
//         QString condition = it.key();
//         bool hasCondition = it.value().toBool();

//         if (hasCondition && severityLevels.contains(condition)) {
//             int severity = severityLevels[condition];
//             if (severity >= 3) {
//                 return false; // User is not eligible to donate
//             }
//         }
//     }

//     return true; // User is eligible to donate
// }

// Add these functions to your DatabaseManager.cpp file

QVariantMap DatabaseManager::getHospitalData(const QString &email)
{
    QVariantMap hospitalData;
    QSqlQuery query;
    query.prepare("SELECT name, email, address, contact_number, profile_image FROM hospitals WHERE email = :email");
    query.bindValue(":email", email);

    if (query.exec() && query.next()) {
        hospitalData["name"] = query.value("name").toString();
        hospitalData["email"] = query.value("email").toString();
        hospitalData["address"] = query.value("address").toString();
        hospitalData["contactNumber"] = query.value("contact_number").toString();
        hospitalData["profileImage"] = query.value("profile_image").toString();
    } else {
        qDebug() << "Error fetching hospital data:" << query.lastError().text();
    }

    return hospitalData;
}

bool DatabaseManager::addHospitalComment(const QString &hospitalEmail, const QString &comment)
{
    QSqlQuery query;
    query.prepare("INSERT INTO hospital_comments (hospital_email, comment, date) VALUES (:hospital_email, :comment, :date)");
    query.bindValue(":hospital_email", hospitalEmail);
    query.bindValue(":comment", comment);
    query.bindValue(":date", QDateTime::currentDateTime().toString(Qt::ISODate));

    if (query.exec()) {
        qDebug() << "Comment added successfully";
        return true;
    } else {
        qDebug() << "Error adding comment:" << query.lastError().text();
        return false;
    }
}

QVariantList DatabaseManager::getHospitalComments(const QString &hospitalEmail)
{
    QVariantList comments;
    QSqlQuery query;
    query.prepare("SELECT comment, date FROM hospital_comments WHERE hospital_email = :hospital_email ORDER BY date DESC");
    query.bindValue(":hospital_email", hospitalEmail);

    if (query.exec()) {
        while (query.next()) {
            QVariantMap commentData;
            commentData["text"] = query.value("comment").toString();
            commentData["date"] = query.value("date").toString();
            comments.append(commentData);
        }
    } else {
        qDebug() << "Error fetching hospital comments:" << query.lastError().text();
    }

    return comments;
}

int DatabaseManager::getLastUserID()
{
    QSqlQuery query;
    query.exec("SELECT last_insert_rowid()");

    if (query.next()) {
        return query.value(0).toInt();
    } else {
        qDebug() << "Error getting last insert ID:" << query.lastError().text();
        return -1;  // Return -1 to indicate an error
    }
}

void DatabaseManager::initializeDatabase()
{
    m_database = QSqlDatabase::addDatabase("QSQLITE");
    m_database.setDatabaseName("bloodbank.db");

    if (m_database.open()) {
        qDebug() << "Database opened successfully";
        QSqlQuery query;
        query.exec("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT UNIQUE, password TEXT)");
        query.exec("CREATE TABLE IF NOT EXISTS hospitals (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT UNIQUE, password TEXT)");
        query.exec("CREATE TABLE IF NOT EXISTS blood_donation (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INTEGER, donation_date TEXT, diabetes INTEGER, hepatitis INTEGER, hiv_aids INTEGER, blood_amount REAL, FOREIGN KEY (user_id) REFERENCES users(id))");
    } else {
        qDebug() << "Error opening database:" << m_database.lastError().text();
    }
}
