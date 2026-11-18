
import SwiftUI

struct PlantRow: View {

    @Binding var plant: Plant

    private let sunColor = Color(red: 0.80, green: 0.78, blue: 0.52).opacity(0.68)
    private let checkGreen = Color(red: 40 / 255, green: 224 / 255, blue: 168 / 255)
    private let waterColor = Color(red: 0.79, green: 0.95, blue: 0.98)

    var body: some View {

        VStack(spacing: 12) {

            HStack(spacing: 14) {

                Button {
                    plant.isDone.toggle()
                } label: {
                    Image(systemName: plant.isDone ? "checkmark.circle.fill" : "circle")
                        .font(.title)
                        .foregroundStyle(plant.isDone ? checkGreen : Color.gray)
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

                Spacer(minLength: 0)
            }

            Divider()
                .overlay(Color.white.opacity(0.15))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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

