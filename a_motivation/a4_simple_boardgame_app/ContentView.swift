// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            LandingScreen(selection: $selectedTab).tabItem {
                Label("Welcome", systemImage: "1.circle")
            }.tag(0)
            TicTacToeScreen().tabItem {
                Label("Play", systemImage: "2.circle")
            }.tag(1)
        }
        .onAppear { selectedTab = loadSelectedTab() }
        .onChange(of: selectedTab) { oldState, newState in saveSelectedTab(newState) }
    }

    private static let selectedTabKey = "lastSelectedTab"

    private func loadSelectedTab() -> Int {
        return UserDefaults.standard.integer(forKey: ContentView.selectedTabKey)
    }

    private func saveSelectedTab(_ newState: Int) {
        UserDefaults.standard.set(newState, forKey: ContentView.selectedTabKey)
    }
}
