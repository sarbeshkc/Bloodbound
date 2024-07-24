#include "DatabaseManager.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include <QDateTime>
#include <QCryptographicHash>

DatabaseManager::DatabaseManager(QObject *parent)
    : QObject(parent)
{
    initializeDatabase();
}

// DatabaseManager::~DatabaseManager()
// {
//     if (m_database.isOpen()) {
//         m_database.close();
//     }
// }

void DatabaseManager::initializeDatabase()
{
    m_database = QSqlDatabase::addDatabase("QSQLITE");
    m_database.setDatabaseName("bllaalf.db");

    if (m_database.open()) {
        qDebug() << "Database opened successfully";
        createTables();
    } else {
        qDebug() << "Error opening database:" << m_database.lastError().text();
    }
}

void DatabaseManager::createTables()
{
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS users ("
               "id INTEGER PRIMARY KEY AUTOINCREMENT, "
               "name TEXT, "
               "email TEXT UNIQUE, "
               "password TEXT, "
               "hashed_password TEXT, "
               "blood_group TEXT, "
               "health_info TEXT, "
               "contact_number TEXT, "
               "address TEXT)");

    query.exec("CREATE TABLE IF NOT EXISTS hospitals ("
                "   id INTEGER PRIMARY KEY AUTOINCREMENT,"
                   "name TEXT NOT NULL,"
                   "email TEXT NOT NULL UNIQUE,"
                   "password TEXT NOT NULL,"
                   "contact_number TEXT NOT NULL,"
                   "address TEXT NOT NULL,"
                   "city TEXT NOT NULL,"
                   "state TEXT NOT NULL,"
                   "country TEXT NOT NULL,"
                   "zip TEXT NOT NULL,"
                   "license TEXT NOT NULL)"
                   );

    query.exec("CREATE TABLE IF NOT EXISTS blood_donation ("
               "id INTEGER PRIMARY KEY AUTOINCREMENT, "
               "user_email TEXT, "
               "donation_date TEXT, "
               "blood_amount REAL, "
               "FOREIGN KEY (user_email) REFERENCES users(email))");

    query.exec("CREATE TABLE IF NOT EXISTS user_comments ("
               "id INTEGER PRIMARY KEY AUTOINCREMENT, "
               "user_email TEXT, "
               "comment_date TEXT, "
               "comment_text TEXT, "
               "FOREIGN KEY (user_email) REFERENCES users(email))");

    query.exec("CREATE TABLE IF NOT EXISTS appointments ("
               "id INTEGER PRIMARY KEY AUTOINCREMENT, "
               "user_email TEXT, "
               "hospital_email TEXT, "
               "appointment_date TEXT, "
               "FOREIGN KEY (user_email) REFERENCES users(email), "
               "FOREIGN KEY (hospital_email) REFERENCES hospitals(email))");
}

QString DatabaseManager::hashPassword(const QString &password)
{
    QByteArray hash = QCryptographicHash::hash(password.toUtf8(), QCryptographicHash::Sha256);
    return QString(hash.toHex());
}

bool DatabaseManager::insertUser(const QString &name, const QString &email, const QString &password, const QString &bloodGroup, const QString &healthInfo)
{
    QSqlQuery query;
    query.prepare("INSERT INTO users (name, email, password, hashed_password, blood_group, health_info) "
                  "VALUES (:name, :email, :password, :hashed_password, :blood_group, :health_info)");
    query.bindValue(":name", name);
    query.bindValue(":email", email);
    query.bindValue(":password", password);
    query.bindValue(":hashed_password", hashPassword(password));
    query.bindValue(":blood_group", bloodGroup);
    query.bindValue(":health_info", healthInfo);

    if (query.exec()) {
        qDebug() << "User inserted successfully";
        return true;
    } else {
        qDebug() << "Error inserting user:" << query.lastError().text();
        return false;
    }
}

bool DatabaseManager::insertHospital(const QString &name, const QString &email, const QString &password,
                               const QString &contactNumber, const QString &address, const QString &city,
                               const QString &state, const QString &country, const QString &zip,
                               const QString &license)
{
    QSqlQuery query;
    query.prepare("INSERT INTO hospitals (name, email, password, contact_number, address, city, state, country, zip, license) "
                  "VALUES (:name, :email, :password, :contact_number, :address, :city, :state, :country, :zip, :license)");

    query.bindValue(":name", name);
    query.bindValue(":email", email);
    query.bindValue(":password", QCryptographicHash::hash(password.toUtf8(), QCryptographicHash::Sha256).toHex());
    query.bindValue(":contact_number", contactNumber);
    query.bindValue(":address", address);
    query.bindValue(":city", city);
    query.bindValue(":state", state);
    query.bindValue(":country", country);
    query.bindValue(":zip", zip);
    query.bindValue(":license", license);

    if (!query.exec()) {
        qDebug() << "Error inserting hospital:" << query.lastError().text();
        return false;
    }

    return true;
}

bool DatabaseManager::userLogin(const QString &email, const QString &password)
{
    QSqlQuery query;
    query.prepare("SELECT password, hashed_password FROM users WHERE email = :email");
    query.bindValue(":email", email);

    if (query.exec() && query.next()) {
        QString storedPassword = query.value("password").toString();
        QString storedHashedPassword = query.value("hashed_password").toString();
        if (password == storedPassword || hashPassword(password) == storedHashedPassword) {
            qDebug() << "User login successful";
            return true;
        } else {
            qDebug() << "User login failed: incorrect password";
            return false;
        }
    } else {
        qDebug() << "User login failed: user not found";
        return false;
    }
}

bool DatabaseManager::hospitalLogin(const QString &email, const QString &password)
{
    QSqlQuery query;
    query.prepare("SELECT password FROM hospitals WHERE email = :email");
    query.bindValue(":email", email);

    if (!query.exec()) {
        qDebug() << "Error executing query:" << query.lastError().text();
        return false;
    }

    if (query.next()) {
        QString storedPassword = query.value(0).toString();
        QString hashedInputPassword = QCryptographicHash::hash(password.toUtf8(), QCryptographicHash::Sha256).toHex();

        return (storedPassword == hashedInputPassword);
    }

    return false;
}

void DatabaseManager::donateUser(const QString &email, double bloodAmount)
{
    QSqlQuery query;
    query.prepare("INSERT INTO blood_donation (user_email, donation_date, blood_amount) "
                  "VALUES (:email, :donation_date, :blood_amount)");
    query.bindValue(":email", email);
    query.bindValue(":donation_date", QDateTime::currentDateTime().toString(Qt::ISODate));
    query.bindValue(":blood_amount", bloodAmount);

    if (query.exec()) {
        qDebug() << "Donation record inserted successfully";
    } else {
        qDebug() << "Error inserting donation record:" << query.lastError().text();
    }
}

QVariantMap DatabaseManager::getUserData(const QString &email)
{
    QVariantMap userData;
    QSqlQuery query;
    query.prepare("SELECT name, email, blood_group, health_info, contact_number, address "
                  "FROM users WHERE email = :email");
    query.bindValue(":email", email);

    if (query.exec() && query.next()) {
        userData["name"] = query.value("name").toString();
        userData["email"] = query.value("email").toString();
        userData["bloodGroup"] = query.value("blood_group").toString();
        userData["healthInfo"] = query.value("health_info").toString();
        userData["contactNumber"] = query.value("contact_number").toString();
        userData["address"] = query.value("address").toString();
    } else {
        qDebug() << "Error fetching user data:" << query.lastError().text();
    }

    return userData;
}

QVariantMap DatabaseManager::getHospitalData(const QString &email)
{
    QVariantMap hospitalData;
    QSqlQuery query;
    query.prepare("SELECT name, email FROM hospitals WHERE email = :email");
    query.bindValue(":email", email);

    if (query.exec() && query.next()) {
        hospitalData["name"] = query.value("name").toString();
        hospitalData["email"] = query.value("email").toString();
    } else {
        qDebug() << "Error fetching hospital data:" << query.lastError().text();
    }

    return hospitalData;
}

QVariantList DatabaseManager::getUserDonationHistory(const QString &email)
{
    QVariantList donationHistory;
    QSqlQuery query;
    query.prepare("SELECT donation_date, blood_amount FROM blood_donation "
                  "WHERE user_email = :email ORDER BY donation_date DESC");
    query.bindValue(":email", email);

    if (query.exec()) {
        while (query.next()) {
            QVariantMap donation;
            donation["date"] = query.value("donation_date").toDateTime().toString("yyyy-MM-dd");
            donation["amount"] = query.value("blood_amount").toDouble();
            donationHistory.append(donation);
        }
    } else {
        qDebug() << "Error fetching donation history:" << query.lastError().text();
    }

    return donationHistory;
}

QVariantList DatabaseManager::getUserComments(const QString &email)
{
    QVariantList comments;
    QSqlQuery query;
    query.prepare("SELECT comment_date, comment_text FROM user_comments "
                  "WHERE user_email = :email ORDER BY comment_date DESC");
    query.bindValue(":email", email);

    if (query.exec()) {
        while (query.next()) {
            QVariantMap comment;
            comment["date"] = query.value("comment_date").toDateTime().toString("yyyy-MM-dd HH:mm");
            comment["comment"] = query.value("comment_text").toString();
            comments.append(comment);
        }
    } else {
        qDebug() << "Error fetching user comments:" << query.lastError().text();
    }

    return comments;
}

bool DatabaseManager::addUserComment(const QString &email, const QString &commentText)
{
    QSqlQuery query;
    query.prepare("INSERT INTO user_comments (user_email, comment_date, comment_text) "
                  "VALUES (:email, :date, :comment)");
    query.bindValue(":email", email);
    query.bindValue(":date", QDateTime::currentDateTime().toString(Qt::ISODate));
    query.bindValue(":comment", commentText);

    if (query.exec()) {
        qDebug() << "User comment added successfully";
        return true;
    } else {
        qDebug() << "Error adding user comment:" << query.lastError().text();
        return false;
    }
}

QVariantList DatabaseManager::getHospitalList()
{
    QVariantList hospitals;
    QSqlQuery query("SELECT name, email FROM hospitals");

    if (query.exec()) {
        while (query.next()) {
            QVariantMap hospital;
            hospital["name"] = query.value("name").toString();
            hospital["email"] = query.value("email").toString();
            hospitals.append(hospital);
        }
    } else {
        qDebug() << "Error fetching hospital list:" << query.lastError().text();
    }

    return hospitals;
}

bool DatabaseManager::deleteUser(const QString &email, const QString &password)
{
    QSqlQuery query;
    query.prepare("SELECT password, hashed_password FROM users WHERE email = :email");
    query.bindValue(":email", email);

    if (query.exec() && query.next()) {
        QString storedPassword = query.value("password").toString();
        QString storedHashedPassword = query.value("hashed_password").toString();
        if (password == storedPassword || hashPassword(password) == storedHashedPassword) {
            query.prepare("DELETE FROM users WHERE email = :email");
            query.bindValue(":email", email);
            if (query.exec()) {
                qDebug() << "User deleted successfully";
                return true;
            } else {
                qDebug() << "Error deleting user:" << query.lastError().text();
            }
        } else {
            qDebug() << "Incorrect password for user deletion";
        }
    } else {
        qDebug() << "User not found for deletion";
    }
    return false;
}

bool DatabaseManager::deleteHospital(const QString &email, const QString &password)
{
    QSqlQuery query;
    query.prepare("SELECT password, hashed_password FROM hospitals WHERE email = :email");
    query.bindValue(":email", email);

    if (query.exec() && query.next()) {
        QString storedPassword = query.value("password").toString();
        QString storedHashedPassword = query.value("hashed_password").toString();
        if (password == storedPassword || hashPassword(password) == storedHashedPassword) {
            query.prepare("DELETE FROM hospitals WHERE email = :email");
            query.bindValue(":email", email);
            if (query.exec()) {
                qDebug() << "Hospital deleted successfully";
                return true;
            } else {
                qDebug() << "Error deleting hospital:" << query.lastError().text();
            }
        } else {
            qDebug() << "Incorrect password for hospital deletion";
        }
    } else {
        qDebug() << "Hospital not found for deletion";
    }
    return false;
}

bool DatabaseManager::changeUserPassword(const QString &email, const QString &oldPassword, const QString &newPassword)
{
    QSqlQuery query;
    query.prepare("SELECT password, hashed_password FROM users WHERE email = :email");
    query.bindValue(":email", email);

    if (query.exec() && query.next()) {
        QString storedPassword = query.value("password").toString();
        QString storedHashedPassword = query.value("hashed_password").toString();
        if (oldPassword == storedPassword || hashPassword(oldPassword) == storedHashedPassword) {
            query.prepare("UPDATE users SET password = :newPassword, hashed_password = :newHashedPassword WHERE email = :email");
            query.bindValue(":newPassword", newPassword);
            query.bindValue(":newHashedPassword", hashPassword(newPassword));
            query.bindValue(":email", email);
            if (query.exec()) {
                qDebug() << "User password changed successfully";
                return true;
            } else {
                qDebug() << "Error changing user password:" << query.lastError().text();
            }
        } else {
            qDebug() << "Incorrect old password for user";
        }
    } else {
        qDebug() << "User not found for password change";
    }
    return false;
}

bool DatabaseManager::changeHospitalPassword(const QString &email, const QString &oldPassword, const QString &newPassword)
{
    QSqlQuery query;
    query.prepare("SELECT password, hashed_password FROM hospitals WHERE email = :email");
    query.bindValue(":email", email);

    if (query.exec() && query.next()) {
        QString storedPassword = query.value("password").toString();
        QString storedHashedPassword = query.value("hashed_password").toString();
        if (oldPassword == storedPassword || hashPassword(oldPassword) == storedHashedPassword) {
            query.prepare("UPDATE hospitals SET password = :newPassword, hashed_password = :newHashedPassword WHERE email = :email");
            query.bindValue(":newPassword", newPassword);
            query.bindValue(":newHashedPassword", hashPassword(newPassword));
            query.bindValue(":email", email);
            if (query.exec()) {
                qDebug() << "Hospital password changed successfully";
                return true;
            } else {
                qDebug() << "Error changing hospital password:" << query.lastError().text();
            }
        } else {
            qDebug() << "Incorrect old password for hospital";
        }
    } else {
        qDebug() << "Hospital not found for password change";
    }
    return false;
}

QVariantList DatabaseManager::searchDonors(const QString &bloodGroup, const QString &location)
{
    QVariantList donors;
    QSqlQuery query;
    query.prepare("SELECT name, email, blood_group, address FROM users "
                  "WHERE blood_group = :bloodGroup AND address LIKE :location");
    query.bindValue(":bloodGroup", bloodGroup);
    query.bindValue(":location", "%" + location + "%");

    if (query.exec()) {
        while (query.next()) {
            QVariantMap donor;
            donor["name"] = query.value("name").toString();
            donor["email"] = query.value("email").toString();
            donor["bloodGroup"] = query.value("blood_group").toString();
            donor["address"] = query.value("address").toString();
            donors.append(donor);
        }
    } else {
        qDebug() << "Error searching donors:" << query.lastError().text();
    }

    return donors;
}

bool DatabaseManager::updateUserProfile(const QString &email, const QVariantMap &userData)
{
    QSqlQuery query;
    query.prepare("UPDATE users SET name = :name, blood_group = :bloodGroup, "
                  "health_info = :healthInfo, contact_number = :contactNumber, "
                  "address = :address WHERE email = :email");
    query.bindValue(":name", userData["name"].toString());
    query.bindValue(":bloodGroup", userData["bloodGroup"].toString());
    query.bindValue(":healthInfo", userData["healthInfo"].toString());
    query.bindValue(":contactNumber", userData["contactNumber"].toString());
    query.bindValue(":address", userData["address"].toString());
    query.bindValue(":email", email);

    if (query.exec()) {
        qDebug() << "User profile updated successfully";
        return true;
    } else {
        qDebug() << "Error updating user profile:" << query.lastError().text();
        return false;
    }
}

bool DatabaseManager::updateHospitalProfile(const QString &email, const QVariantMap &hospitalData)
{
    QSqlQuery query;
    query.prepare("UPDATE hospitals SET name = :name WHERE email = :email");
    query.bindValue(":name", hospitalData["name"].toString());
    query.bindValue(":email", email);

    if (query.exec()) {
        qDebug() << "Hospital profile updated successfully";
        return true;
    } else {
        qDebug() << "Error updating hospital profile:" << query.lastError().text();
        return false;
    }
}

QVariantList DatabaseManager::getRecentDonations(int limit)
{
    QVariantList recentDonations;
    QSqlQuery query;
    query.prepare("SELECT u.name, u.blood_group, bd.donation_date, bd.blood_amount "
                  "FROM blood_donation bd "
                  "JOIN users u ON bd.user_email = u.email "
                  "ORDER BY bd.donation_date DESC LIMIT :limit");
    query.bindValue(":limit", limit);

    if (query.exec()) {
        while (query.next()) {
            QVariantMap donation;
            donation["name"] = query.value("name").toString();
            donation["bloodGroup"] = query.value("blood_group").toString();
            donation["date"] = query.value("donation_date").toDateTime().toString("yyyy-MM-dd");
            donation["amount"] = query.value("blood_amount").toDouble();
            recentDonations.append(donation);
        }
    } else {
        qDebug() << "Error fetching recent donations:" << query.lastError().text();
    }

    return recentDonations;
}

QVariantMap DatabaseManager::getBloodInventory()
{
    QVariantMap inventory;
    QSqlQuery query("SELECT blood_group, SUM(blood_amount) as total_amount "
                    "FROM blood_donation "
                    "JOIN users ON blood_donation.user_email = users.email "
                    "GROUP BY blood_group");

    if (query.exec()) {
        while (query.next()) {
            QString bloodGroup = query.value("blood_group").toString();
            double totalAmount = query.value("total_amount").toDouble();
            inventory[bloodGroup] = totalAmount;
        }
    } else {
        qDebug() << "Error fetching blood inventory:" << query.lastError().text();
    }

    return inventory;
}

bool DatabaseManager::scheduleAppointment(const QString &userEmail, const QString &hospitalEmail, const QDateTime &appointmentDate)
{
    QSqlQuery query;
    query.prepare("INSERT INTO appointments (user_email, hospital_email, appointment_date) "
                  "VALUES (:userEmail, :hospitalEmail, :appointmentDate)");
    query.bindValue(":userEmail", userEmail);
    query.bindValue(":hospitalEmail", hospitalEmail);
    query.bindValue(":appointmentDate", appointmentDate.toString(Qt::ISODate));

    if (query.exec()) {
        qDebug() << "Appointment scheduled successfully";
        return true;
    } else {
        qDebug() << "Error scheduling appointment:" << query.lastError().text();
        return false;
    }
}

QVariantList DatabaseManager::getUserAppointments(const QString &userEmail)
{
    QVariantList appointments;
    QSqlQuery query;
    query.prepare("SELECT a.appointment_date, h.name as hospital_name "
                  "FROM appointments a "
                  "JOIN hospitals h ON a.hospital_email = h.email "
                  "WHERE a.user_email = :userEmail "
                  "ORDER BY a.appointment_date");
    query.bindValue(":userEmail", userEmail);

    if (query.exec()) {
        while (query.next()) {
            QVariantMap appointment;
            appointment["date"] = query.value("appointment_date").toDateTime();
            appointment["hospitalName"] = query.value("hospital_name").toString();
            appointments.append(appointment);
        }
    } else {
        qDebug() << "Error fetching user appointments:" << query.lastError().text();
    }

    return appointments;
}

QVariantList DatabaseManager::getHospitalAppointments(const QString &hospitalEmail)
{
    QVariantList appointments;
    QSqlQuery query;
    query.prepare("SELECT a.appointment_date, u.name as user_name, u.blood_group "
                  "FROM appointments a "
                  "JOIN users u ON a.user_email = u.email "
                  "WHERE a.hospital_email = :hospitalEmail "
                  "ORDER BY a.appointment_date");
    query.bindValue(":hospitalEmail", hospitalEmail);

    if (query.exec()) {
        while (query.next()) {
            QVariantMap appointment;
            appointment["date"] = query.value("appointment_date").toDateTime();
            appointment["userName"] = query.value("user_name").toString();
            appointment["bloodGroup"] = query.value("blood_group").toString();
            appointments.append(appointment);
        }
    } else {
        qDebug() << "Error fetching hospital appointments:" << query.lastError().text();
    }

    return appointments;
}
