import SwiftUI

struct AllDoneView: View {
    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            ZStack {
                Circle()
                    .fill(Color(red: 0.078, green: 0.078, blue: 0.102).opacity(0.58))
                    .frame(width: 219, height: 219)

                Image("plantMascotWink")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 220)
            }

            Text("All Done! 🎉")
                .font(.headline)
                .foregroundStyle(Color.white)

            Text("All Reminders Completed")
                .font(.caption)
                .foregroundStyle(Color.gray)

            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        AllDoneView()
    }
}
