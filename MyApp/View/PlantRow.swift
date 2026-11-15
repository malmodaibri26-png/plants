import SwiftUI

struct PlantRow: View {
    @Binding var plant: Plant

    
    private let sunColor = Color(red: 0.80, green: 0.78, blue: 0.52).opacity(0.68)
   
    private let waterColor = Color(red: 0.79, green: 0.95, blue: 0.98)

    var body: some View {
        HStack(spacing: 14) {
            Button {
                plant.isDone.toggle()
            } label: {
                Image(systemName: plant.isDone ? "checkmark.circle.fill" : "circle")
                    .font(.title)
                    .foregroundStyle(plant.isDone ? Color.green : Color.gray)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 6) {
                Label("in \(plant.room)", systemImage: "location")
                    .font(.caption)
                    .foregroundStyle(Color.gray)

                Text(plant.name)
                    .font(.title2)
                    .foregroundStyle(plant.isDone ? Color.gray : Color.white)

                HStack(spacing: 8) {
                    tag(icon: "sun.max", text: plant.light, color: sunColor, weight: .regular)
                    tag(icon: "drop", text: plant.water, color: waterColor, weight: .medium)
                }
            }
        }
        .opacity(plant.isDone ? 0.7 : 1)
    }

    private func tag(icon: String, text: String, color: Color, weight: Font.Weight) -> some View {
        Label(text, systemImage: icon)
            .font(.system(size: 14, weight: weight))
            .foregroundStyle(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.white.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
    }
}
