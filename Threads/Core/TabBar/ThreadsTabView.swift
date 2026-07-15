import SwiftUI

struct ThreadsTabView: View {
    @State private var selectedTab = 0
    @State private var showCreateThreadView = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill: .none)
                    Text("Feed")
                }
                .onAppear {selectedTab = 0}
                .tag(0)
            
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                    Text("Explore")
                }
                .onAppear {selectedTab = 1}
                .tag(1)

            ProgressView()
                .tabItem {
                    Image(systemName: "plus")
                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                    Text("Upload")
                }
                .onAppear {
                    selectedTab = 2
                    showCreateThreadView = true
                }
                .tag(2)

            ActivityView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                    Text("Activity")
                }
                .onAppear {selectedTab = 3}
                .tag(3)

            ProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                    Text("Profile")
                }
                .onAppear {selectedTab = 4}
                .tag(4)
        }
        // .onChange(of: selectedTab, perform: { newValue in showCreateThreadView = selectedTab == 2 })
        .sheet(isPresented: $showCreateThreadView, onDismiss: {selectedTab = 0}, content: { CreateThreadView() })
        .tint(Color.black)
    }
}

#Preview {
    ThreadsTabView()
}
