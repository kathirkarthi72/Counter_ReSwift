//
//  PostsListView.swift
//  Learn ReSwift
//
//  View displaying Asynchronous ReSwiftThunk network actions.
//

import SwiftUI

struct PostsListView: View {
    @EnvironmentObject var store: ObservableStore<AppState>
    
    private var postsState: PostsState {
        store.state.postsState
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if postsState.isLoading && postsState.posts.isEmpty {
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.3)
                        Text("Fetching posts via ReSwiftThunk...")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxHeight: .infinity)
                } else if let errorMsg = postsState.errorMessage, postsState.posts.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.orange)
                        
                        Text("Failed to load posts")
                            .font(.headline)
                        
                        Text(errorMsg)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                        
                        Button("Retry Fetching") {
                            store.dispatch(fetchPostsThunk())
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .frame(maxHeight: .infinity)
                } else {
                    List {
                        Section {
                            ForEach(postsState.filteredPosts) { post in
                                PostRowView(post: post) {
                                    store.dispatch(PostsAction.toggleFavorite(id: post.id))
                                }
                            }
                        } header: {
                            Text("Posts (\(postsState.filteredPosts.count))")
                        } footer: {
                            Text("ReSwiftThunk dispatches start, success, or error actions asynchronously.")
                        }
                    }
                    .listStyle(.insetGrouped)
                    .refreshable {
                        store.dispatch(fetchPostsThunk())
                    }
                }
            }
            .navigationTitle("Posts (Async Thunk)")
            .searchable(
                text: Binding(
                    get: { postsState.searchQuery },
                    set: { query in store.dispatch(PostsAction.setSearchQuery(query)) }
                ),
                prompt: "Search posts by title or body"
            )
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        store.dispatch(fetchPostsThunk())
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .onAppear {
                if postsState.posts.isEmpty {
                    store.dispatch(fetchPostsThunk())
                }
            }
        }
    }
}

#Preview {
    PostsListView()
        .environmentObject(ObservableStore(store: mainStore))
}
