//
//  AppState.swift
//  Learn ReSwift
//
//  ReSwift Concept: STATE
//  ---------------------
//  The AppState is the single source of truth for the entire application.
//  It conforms to ReSwift's `StateType`.
//  In a modular app, AppState is split into logical sub-states.
//

import Foundation
import ReSwift

// MARK: - 1. Counter Sub-State
/// Sub-state managing counter calculations.
public struct CounterState: Equatable {
    public var value: Int = 0
    public var step: Int = 1
    public var totalOperations: Int = 0
    
    public init() {}
}

// MARK: - 2. Posts Sub-State
/// Sub-state managing async API posts, loading indicators, and errors.
public struct PostsState: Equatable {
    public var posts: [Post] = []
    public var isLoading: Bool = false
    public var errorMessage: String? = nil
    public var searchQuery: String = ""
    
    public init() {}
    
    /// Filtered list based on current `searchQuery`.
    public var filteredPosts: [Post] {
        if searchQuery.isEmpty {
            return posts
        }
        return posts.filter {
            $0.title.localizedCaseInsensitiveContains(searchQuery) ||
            $0.body.localizedCaseInsensitiveContains(searchQuery)
        }
    }
}

// MARK: - 3. User & Settings Sub-State
/// Sub-state managing user profile data and global application preferences.
public struct UserState: Equatable {
    public var username: String = "Swift Developer"
    public var email: String = "developer@apple.com"
    public var isDarkMode: Bool = false
    public var notificationsEnabled: Bool = true
    
    public init() {}
}

// MARK: - Root App State
/// The root state tree implementing ReSwift's `StateType`.
public struct AppState: StateType, Equatable {
    public var counterState: CounterState
    public var postsState: PostsState
    public var userState: UserState
    
    public init(
        counterState: CounterState = CounterState(),
        postsState: PostsState = PostsState(),
        userState: UserState = UserState()
    ) {
        self.counterState = counterState
        self.postsState = postsState
        self.userState = userState
    }
}
