//
//  Store.swift
//  Learn ReSwift
//
//  ReSwift Concept: STORE
//  ----------------------
//  The Store is the global object that holds the AppState.
//  It accepts dispatched Actions/Thunks, feeds them to the Reducer,
//  and notifies Subscribers whenever state changes.
//

import Foundation
import ReSwift
import ReSwiftThunk

/// Global singleton store instance initialized with root appReducer and ReSwiftThunk middleware.
public let mainStore = Store<AppState>(
    reducer: appReducer,
    state: nil,
    middleware: [createThunkMiddleware()]
)
