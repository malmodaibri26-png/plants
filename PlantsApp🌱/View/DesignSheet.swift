import SwiftUI

struct DesignSheet<Content: View>: View {
    @ViewBuilder var content: Content

    private let background = Color(red: 0.11, green: 0.11, blue: 0.118) // #1C1C1E

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()

            UnevenRoundedRectangle(
                topLeadingRadius: 39,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 39
            )
            .fill(background)
            .ignoresSafeArea(edges: .bottom)
            .overlay(content)
            .padding(.top, 12)
        }
    }
}
