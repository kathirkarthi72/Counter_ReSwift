//
//  PostService.swift
//  Learn ReSwift
//
//  Service responsible for fetching remote post data.
//  Used inside ReSwiftThunks to isolate side-effects from Reducers.
//

import Foundation

public protocol PostServiceProtocol {
    func fetchPosts() async throws -> [Post]
}

public class PostService: PostServiceProtocol {
    public static let shared = PostService()
    
    private let urlString = "https://jsonplaceholder.typicode.com/posts"
    
    public init() {}
    
    public func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        do {
            // Simulated artificial delay for learning UI state visualization (loading spinner)
            try await Task.sleep(nanoseconds: 1_000_000_000)
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let posts = try JSONDecoder().decode([Post].self, from: data)
            // Limit to first 15 posts for clean demo UI
            return Array(posts.prefix(15))
        } catch {
            // Fallback mock posts in case offline/network failure
            return mockPosts
        }
    }
    
    /// Fallback sample posts to ensure offline usability & reliability during testing.
    public var mockPosts: [Post] {
        [
            Post(id: 1, userId: 1, title: "Understanding ReSwift State", body: "ReSwift provides a single state tree storing all app state immutably."),
            Post(id: 2, userId: 1, title: "Pure Reducers in Action", body: "Reducers take (Action, State) and return a new State without side-effects."),
            Post(id: 3, userId: 2, title: "Asynchronous Actions with ReSwiftThunk", body: "Thunks allow side-effects such as API requests before dispatching pure actions."),
            Post(id: 4, userId: 2, title: "Unidirectional Data Flow in SwiftUI", body: "State flows down into views; actions flow up into the Redux store.")
        ]
    }
}
