pragma Singleton
import QtQuick 2.15

QtObject {
    readonly property var nearestHospitals: [
        { name: "City General Hospital", email: "city.general@example.com", distance: "2.5 km" },
        { name: "St. Mary's Medical Center", email: "stmarys@example.com", distance: "3.8 km" },
        { name: "Riverside Community Hospital", email: "riverside@example.com", distance: "5.2 km" },
        { name: "Memorial Health Institute", email: "memorial@example.com", distance: "6.7 km" },
        { name: "Central Medical Center", email: "central@example.com", distance: "8.1 km" }
    ]

    // You can add more mock data properties here as needed
}
