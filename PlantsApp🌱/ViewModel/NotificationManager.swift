import UserNotifications

final class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()

 
    func setup() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound]) { _, _ in }
    }

    func scheduleReminder(for plant: Plant) {
        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Hey! let's water your plant"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: reminderInterval(for: plant.wateringDays),
            repeats: true
        )
        let request = UNNotificationRequest(
            identifier: plant.id.uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }

    private func reminderInterval(for wateringDays: String) -> TimeInterval {
        let days: Double
        switch wateringDays {
        case "Every 2 days":
            days = 2
        case "Every 3 days":
            days = 3
        case "Once a week":
            days = 7
        case "Every 10 days":
            days = 10
        case "Every 2 weeks":
            days = 14
        default:
            days = 1
        }

        return days * 24 * 60 * 60
    }


    func cancelReminder(for plant: Plant) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])
    }

   func scheduleTest() {
        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Hey! let's water your plant"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        [.banner, .sound]
    }
}
