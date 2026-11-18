import SwiftUI

struct ContentView: View {

    @StateObject private var store = PlantStore()
    @AppStorage("hasStarted") private var hasStarted = false
    @State private var showAdd = false
    @State private var editingPlant: Plant?

    var body: some View {

        Group {
            if store.isEmpty && !hasStarted {
                StartJourneyView { showAdd = true }
            } else {
                plantsScreen
            }
        }
        .sheet(isPresented: $showAdd) {
            SetReminderView { plant in
                store.add(plant)
                hasStarted = true
            }
            .presentationBackground(Color(red: 0.11, green: 0.11, blue: 0.118))
        }
        .sheet(item: $editingPlant) { plant in
            SetReminderView(
                plant: plant,
                onSave: { store.update($0) },
                onDelete: { store.delete(plant) }
            )
            .presentationBackground(Color(red: 0.11, green: 0.11, blue: 0.118))
        }
    }

    private var plantsScreen: some View {

        ZStack(alignment: .bottomTrailing) {

            Color.black.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {

                Text("My Plants 🌱")
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color.white)
                    .padding(.horizontal)
                    .padding(.top, 16)
                    .padding(.bottom, 12)

                Divider().overlay(Color.white.opacity(0.15))

                if store.isEmpty {

                    Spacer()

                    Text("No reminders set yet..")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(Color.gray)
                        .frame(maxWidth: .infinity)

                    Spacer()

                } else if store.allDone {

                    AllDoneView()

                } else {

                    TodayProgressView(done: store.doneCount, total: store.total)

                    List {

                        ForEach($store.plants) { $plant in

                            PlantRow(plant: $plant)
                                .listRowBackground(Color.black)
                                .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 16))
                                .listRowSeparator(.hidden)
                                .contentShape(Rectangle())
                                .onTapGesture { editingPlant = plant }
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {

                                    Button(role: .destructive) {
                                        withAnimation { store.delete(plant) }
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    .tint(.red)
                                }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .animation(.easeInOut, value: store.allDone)

            // الزر خارج الـ VStack، مباشرة داخل الـ ZStack
            AddButton { showAdd = true }
                .padding(.trailing, 30)
                .padding(.bottom, 8)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
