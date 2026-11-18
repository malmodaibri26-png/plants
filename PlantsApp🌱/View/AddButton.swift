import SwiftUI

struct AddButton: View {
    var action: () -> Void

    private let green = Color(red: 0.20, green: 0.50, blue: 0.41) // #338069

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(Color.white)
                .frame(width: 44, height: 44)
                .background(
                    Circle().fill(
                        LinearGradient(
                            colors: [Color(red: 0.28, green: 0.58, blue: 0.48), green],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                )
                .overlay(
                    Circle().stroke(
                        LinearGradient(
                            colors: [Color.white.opacity(0.45), Color.white.opacity(0.08)],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 1.2
                    )
                )
                .shadow(color: .black.opacity(0.25), radius: 8, y: 4)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        AddButton { }
    }
}
