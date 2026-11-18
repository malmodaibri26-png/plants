import Combine
import SwiftUI
import SwiftUI

final class PlantStore: ObservableObject {
    @Published var plants: [Plant] = [] {
        didSet { save() }
    }

    private let key = "savedPlants"

    init() {
        load()
    }

    var total: Int { plants.count }
    var doneCount: Int { plants.filter { $0.isDone }.count }
    var isEmpty: Bool { plants.isEmpty }
    var allDone: Bool { !plants.isEmpty && doneCount == total }
    // في PlantStore.swift
    var sortedIDs: [Plant.ID] {
        let pending = plants.filter { !$0.isDone }
        let done = plants.filter { $0.isDone }
        return (pending + done).map(\.id)
    }

    func add(_ plant: Plant) {
        plants.append(plant)
        NotificationManager.shared.scheduleReminder(for: plant)
    }

    func delete(_ plant: Plant) {
        NotificationManager.shared.cancelReminder(for: plant)
        plants.removeAll { $0.id == plant.id }
    }
    func update(_ plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        plants[index] = plant
        NotificationManager.shared.cancelReminder(for: plant)
        NotificationManager.shared.scheduleReminder(for: plant)
    }

    private func save() {
        if let data = try? JSONEncoder().encode(plants) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let saved = try? JSONDecoder().decode([Plant].self, from: data) else { return }
        plants = saved
        saved.forEach { NotificationManager.shared.scheduleReminder(for: $0) }
    }
}
