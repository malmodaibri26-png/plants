import SwiftUI

struct AllDoneView: View {
    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            ZStack {
                Circle()
                    .fill(Color(white: 0.08))
                    .frame(width: 200, height: 200)

                Image("plantMascotWink")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
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
