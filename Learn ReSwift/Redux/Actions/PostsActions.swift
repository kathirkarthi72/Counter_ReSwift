//
//  PostsActions.swift
//  Learn ReSwift
//
//  ReSwift Actions for Async Posts Module.
//  Notice how async operations are broken into granular pure sync actions:
//  - fetchStarted (triggers loading UI)
//  - fetchSuccess (delivers API data payload)
//  - fetchFailed (delivers error message)
//

import Foundation
import ReSwift

public enum PostsAction: Action {
    case fetchStarted
    case fetchSuccess([Post])
    case fetchFailed(String)
    case toggleFavorite(id: Int)
    case setSearchQuery(String)
}
