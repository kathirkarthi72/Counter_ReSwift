//
//  PostRowView.swift
//  Learn ReSwift
//
//  Subview displaying an individual post item and favorite toggle.
//

import SwiftUI

struct PostRowView: View {
    let post: Post
    let onToggleFavorite: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            VStack(alignment: .leading, spacing: 6) {
                Text(post.title.capitalized)
                    .font(.headline)
                    .lineLimit(2)
                
                Text(post.body)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
            }
            
            Spacer()
            
            Button(action: onToggleFavorite) {
                Image(systemName: post.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(post.isFavorite ? .red : .gray)
                    .font(.title3)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 6)
    }
}
