//
//  AppReducer.swift
//  Learn ReSwift
//
//  ReSwift Concept: ROOT REDUCER COMPOSITION
//  ----------------------------------------
//  The `appReducer` delegates state mutation to sub-reducers for each domain slice.
//  This keeps reducers small, testable, and focused.
//

import Foundation
import ReSwift

public func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        counterState: counterReducer(action: action, state: state?.counterState),
        postsState: postsReducer(action: action, state: state?.postsState),
        userState: userReducer(action: action, state: state?.userState)
    )
}
