//
//  ContentView.swift
//  Learn ReSwift
//
//  Main entry view presenting the application layout.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainTabView()
    }
}

#Preview {
    ContentView()
        .environmentObject(ObservableStore(store: mainStore))
}
