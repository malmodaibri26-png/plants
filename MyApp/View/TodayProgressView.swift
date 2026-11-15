import SwiftUI

struct TodayProgressView: View {
    let done: Int
    let total: Int

    private let green = Color(red: 0.42, green: 0.70, blue: 0.58)

    private var progress: Double {
        total == 0 ? 0 : Double(done) / Double(total)
    }

    private var message: String {
        done == 0
            ? "Your plants are waiting for a sip 💦"
            : "\(done) of your plants feel loved today ✨"
    }

    var body: some View {
        VStack(spacing: 12) {
            Text(message)
                .font(.footnote)
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
                .contentTransition(.opacity)

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.white.opacity(0.15))
                    Capsule()
                        .fill(green)
                        .frame(width: geo.size.width * progress)
                }
            }
            .frame(height: 6)
        }
        .padding(.horizontal, 28)
        .padding(.vertical, 20)
        .animation(.easeInOut, value: done)
    }
}

#Preview {
   
        TodayProgressView(done: 3, total: 4)
    
}
