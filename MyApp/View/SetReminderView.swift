import SwiftUI

struct SetReminderView: View {
    @Environment(\.dismiss) private var dismiss

    private let plant: Plant?
    private let onSave: (Plant) -> Void
    private let onDelete: (() -> Void)?

    @State private var name: String
    @State private var room: String
    @State private var light: String
    @State private var wateringDays: String
    @State private var water: String
    @State private var showDeleteAlert = false

    private let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    private let lights = ["Full Sun", "Partial Sun", "Low Light"]
    private let days = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    private let amounts = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    private let lightIcons = ["Full Sun": "sun.max", "Partial Sun": "sun.haze", "Low Light": "moon"]

    private let fieldColor = Color(white: 0.17)
    private let green = Color(red: 0.24, green: 0.48, blue: 0.40)

    init(plant: Plant? = nil,
         onSave: @escaping (Plant) -> Void,
         onDelete: (() -> Void)? = nil) {
        self.plant = plant
        self.onSave = onSave
        self.onDelete = onDelete
        _name = State(initialValue: plant?.name ?? "")
        _room = State(initialValue: plant?.room ?? "Bedroom")
        _light = State(initialValue: plant?.light ?? "Full Sun")
        _wateringDays = State(initialValue: plant?.wateringDays ?? "Every day")
        _water = State(initialValue: plant?.water ?? "20-50 ml")
    }

    private var isEditing: Bool { plant != nil }

    private var canSave: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        VStack(spacing: 28) {
            header

            HStack(spacing: 8) {
                Text("Plant Name").foregroundStyle(Color.white)
                TextField("", text: $name, prompt: Text("Pothos").foregroundStyle(Color.gray))
                    .foregroundStyle(Color.white)
                    .tint(green)
            }
            .padding(.horizontal, 24)
            .frame(height: 56)
            .background(fieldColor, in: Capsule())

            card {
                row(icon: "location", title: "Room", selection: $room, options: rooms)
                Divider().overlay(Color.white.opacity(0.1))
                row(icon: "sun.max", title: "Light", selection: $light, options: lights)
            }

            card {
                row(icon: "drop", title: "Watering Days", selection: $wateringDays, options: days)
                Divider().overlay(Color.white.opacity(0.1))
                row(icon: "drop", title: "Water", selection: $water, options: amounts)
            }

            if isEditing {
                Button {
                    showDeleteAlert = true
                } label: {
                    Text("Delete Reminder")
                        .font(.body)
                        .foregroundStyle(Color(red: 0.95, green: 0.27, blue: 0.22))
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(fieldColor, in: Capsule())
                }
                .padding(.top, 20)
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .preferredColorScheme(.dark)
        .alert("Delete this reminder?", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                onDelete?()
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
        }
    }

    private var header: some View {
        ZStack {
            Text("Set Reminder")
                .font(.headline)
                .foregroundStyle(Color.white)

            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .foregroundStyle(Color.white)
                        .frame(width: 48, height: 48)
                        .background(Color(white: 0.2), in: Circle())
                }

                Spacer()

                Button {
                    var result = plant ?? Plant(name: "", room: "")
                    result.name = name.trimmingCharacters(in: .whitespaces)
                    result.room = room
                    result.light = light
                    result.water = water
                    result.wateringDays = wateringDays
                    onSave(result)
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.headline)
                        .foregroundStyle(Color.white)
                        .frame(width: 48, height: 48)
                        .background(green, in: Circle())
                }
                .disabled(!canSave)
                .opacity(canSave ? 1 : 0.4)
            }
        }
    }

    private func card<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 0) { content() }
            .padding(.horizontal, 16)
            .background(fieldColor, in: RoundedRectangle(cornerRadius: 24))
    }

    private func row(icon: String, title: String, selection: Binding<String>,
                     options: [String], optionIcons: [String: String] = [:]) -> some View {
        HStack {
            Label(title, systemImage: icon)
                .foregroundStyle(Color.white)
            Spacer()
            Picker(title, selection: selection) {
                ForEach(options, id: \.self) { option in
                    if let symbol = optionIcons[option] {
                        Label(option, systemImage: symbol).tag(option)
                    } else {
                        Text(option).tag(option)
                    }
                }
            }
            .pickerStyle(.menu)
            .tint(Color.gray)
        }
        .frame(height: 44)
    }
}

#Preview("Add") {
    SetReminderView { _ in }
}

#Preview("Edit") {
    SetReminderView(plant: Plant(name: "Pothos", room: "Bedroom"), onSave: { _ in }, onDelete: { })
}
