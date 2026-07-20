//
//  ObservableStore.swift
//  Learn ReSwift
//
//  SwiftUI & ReSwift Bridge
//  ------------------------
//  ReSwift is UI-agnostic and uses `StoreSubscriber` callbacks.
//  `ObservableStore` converts ReSwift store updates into `@Published` state changes
//  so SwiftUI views update reactively and cleanly.
//

import Foundation
import Combine
import ReSwift

@MainActor
public final class ObservableStore<State: StateType>: ObservableObject, StoreSubscriber {
    public typealias StoreSubscriberStateType = State
    
    @Published public private(set) var state: State
    public let store: Store<State>
    
    public init(store: Store<State>) {
        self.store = store
        self.state = store.state
        store.subscribe(self)
    }
    
    deinit {
        store.unsubscribe(self)
    }
    
    // MARK: - StoreSubscriber Callback
    public nonisolated func newState(state: State) {
        Task { @MainActor in
            self.state = state
        }
    }
    
    // MARK: - Helper Dispatch Methods
    public func dispatch(_ action: Action) {
        store.dispatch(action)
    }
}
