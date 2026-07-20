//
//  PostsThunks.swift
//  Learn ReSwift
//
//  ReSwift Concept: THUNKS & SIDE EFFECTS
//  --------------------------------------
//  Pure Reducers cannot execute async operations (URLSession, DB reads, timers).
//  `ReSwiftThunk` provides middleware allowing us to dispatch a `Thunk<AppState>` function.
//
//  How a Thunk Works:
//  1. View dispatches `fetchPostsThunk()` into the store.
//  2. Thunk receives `(dispatch, getState)` parameters.
//  3. Thunk dispatches `fetchStarted` sync action to show loading UI.
//  4. Thunk executes async networking (PostService).
//  5. On completion, Thunk dispatches `fetchSuccess` or `fetchFailed` sync action.
//

import Foundation
import ReSwift
import ReSwiftThunk

/// Thunk function to fetch posts asynchronously from network or mock service.
public func fetchPostsThunk(service: PostServiceProtocol = PostService.shared) -> Thunk<AppState> {
    return Thunk<AppState> { dispatch, getState in
        // Step 1: Notify Redux store that fetching has started
        dispatch(PostsAction.fetchStarted)
        
        // Step 2: Perform async side-effect safely in background Task
        Task {
            do {
                let posts = try await service.fetchPosts()
                
                // Dispatch success action back to main thread store
                await MainActor.run {
                    dispatch(PostsAction.fetchSuccess(posts))
                }
            } catch {
                // Dispatch failure action back to main thread store
                await MainActor.run {
                    dispatch(PostsAction.fetchFailed(error.localizedDescription))
                }
            }
        }
    }
}
