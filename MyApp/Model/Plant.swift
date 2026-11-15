import Foundation

struct Plant: Identifiable, Codable {
    var id = UUID()
    var name: String
    var room: String
    var light: String = "Full Sun"
    var water: String = "20-50 ml"
    var wateringDays: String = "Every day"
    var isDone: Bool = false
}
