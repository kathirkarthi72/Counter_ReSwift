//
//  Learn_ReSwiftApp.swift
//  Learn ReSwift
//
//  Application entry point.
//  Instantiates ObservableStore and injects it into SwiftUI environment.
//

import SwiftUI

@main
struct Learn_ReSwiftApp: App {
    @StateObject private var store = ObservableStore(store: mainStore)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
