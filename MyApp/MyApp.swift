import SwiftUI

@main
struct MyApp: App {
    init() {
        NotificationManager.shared.setup()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
