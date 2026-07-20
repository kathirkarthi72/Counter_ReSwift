//
//  PostsReducer.swift
//  Learn ReSwift
//
//  Pure Reducer handling `PostsState` updates.
//

import Foundation
import ReSwift

public func postsReducer(action: Action, state: PostsState?) -> PostsState {
    var state = state ?? PostsState()
    
    guard let action = action as? PostsAction else {
        return state
    }
    
    switch action {
    case .fetchStarted:
        state.isLoading = true
        state.errorMessage = nil
        
    case .fetchSuccess(let fetchedPosts):
        state.isLoading = false
        state.posts = fetchedPosts
        state.errorMessage = nil
        
    case .fetchFailed(let errorMsg):
        state.isLoading = false
        state.errorMessage = errorMsg
        
    case .toggleFavorite(let id):
        if let index = state.posts.firstIndex(where: { $0.id == id }) {
            state.posts[index].isFavorite.toggle()
        }
        
    case .setSearchQuery(let query):
        state.searchQuery = query
    }
    
    return state
}
