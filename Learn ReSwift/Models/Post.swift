//
//  Post.swift
//  Learn ReSwift
//
//  Model representing a news/blog post item fetched from API or local mock data.
//

import Foundation

/// Post model conforming to `Codable`, `Identifiable`, and `Equatable`.
/// Immutability is key in ReSwift state trees.
public struct Post: Codable, Identifiable, Equatable {
    public let id: Int
    public let userId: Int
    public let title: String
    public let body: String
    public var isFavorite: Bool
    
    public init(id: Int, userId: Int, title: String, body: String, isFavorite: Bool = false) {
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
        self.isFavorite = isFavorite
    }
}
