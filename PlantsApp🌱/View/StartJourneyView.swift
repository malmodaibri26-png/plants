import SwiftUI

struct StartJourneyView: View {
    var onStart: () -> Void

    private let prototypeTextColor = Color(red: 219 / 255, green: 210 / 255, blue: 210 / 255)

    var body: some View {
     
            VStack(alignment: .leading, spacing: 0) {
                Text("My Plants 🌱")
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color.white)
                    .padding(.horizontal)
                    .padding(.top, 16)
                    .padding(.bottom, 12)

                Divider().overlay(Color.white.opacity(0.15))

                Spacer()

                VStack(spacing: 20) {
                    Image("plantMascot")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)

                    Text("Start your plant journey!")
                        .font(.title3.bold())
                        .foregroundStyle(prototypeTextColor)

                    Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                        .font(.footnote)
                        .foregroundStyle(prototypeTextColor)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 60)

                    Button(action: onStart) {
                        Text("Set Plant Reminder")
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(Color.white)
                            .frame(width: 266, height: 44)
                            .background(Color(red: 0.24, green: 0.48, blue: 0.40), in: Capsule())
                            .overlay(Capsule().stroke(Color.white.opacity(0.35), lineWidth: 1))
                    }
                    .padding(.top, 30)
                }
                .frame(maxWidth: .infinity)
                .offset(y: 32)

                Spacer()
                Spacer()
            }
  
    }
}

#Preview {
    StartJourneyView(onStart: {})
}
