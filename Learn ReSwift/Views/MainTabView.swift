//
//  MainTabView.swift
//  Learn ReSwift
//
//  Tab Bar view hosting Counter, Posts, and Profile modules.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var store: ObservableStore<AppState>
    
    var body: some View {
        TabView {
            CounterView()
                .tabItem {
                    Label("Counter", systemImage: "number")
                }
            
            PostsListView()
                .tabItem {
                    Label("Posts", systemImage: "newspaper")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .preferredColorScheme(store.state.userState.isDarkMode ? .dark : .light)
    }
}

#Preview {
    MainTabView()
        .environmentObject(ObservableStore(store: mainStore))
}
