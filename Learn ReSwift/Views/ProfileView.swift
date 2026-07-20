//
//  ProfileView.swift
//  Learn ReSwift
//
//  View displaying User profile settings and global state overview.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var store: ObservableStore<AppState>
    
    private var userState: UserState {
        store.state.userState
    }
    
    private var appState: AppState {
        store.state
    }
    
    @State private var usernameInput: String = ""
    @State private var emailInput: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                // User Details Section
                Section("Profile Details") {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 44))
                            .foregroundStyle(.blue)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(userState.username)
                                .font(.headline)
                            Text(userState.email)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    TextField("Username", text: $usernameInput)
                    TextField("Email", text: $emailInput)
                    
                    Button("Save Profile Changes") {
                        store.dispatch(UserAction.updateProfile(username: usernameInput, email: emailInput))
                    }
                    .disabled(usernameInput.isEmpty || emailInput.isEmpty)
                }
                
                // Preferences Section
                Section("Preferences") {
                    Toggle("Dark Mode Theme", isOn: Binding(
                        get: { userState.isDarkMode },
                        set: { _ in store.dispatch(UserAction.toggleDarkMode) }
                    ))
                    
                    Toggle("Enable Notifications", isOn: Binding(
                        get: { userState.notificationsEnabled },
                        set: { _ in store.dispatch(UserAction.toggleNotifications) }
                    ))
                }
                
                // Global AppState Summary Section
                Section("Redux State Summary") {
                    LabeledContent("Counter Value", value: "\(appState.counterState.value)")
                    LabeledContent("Counter Operations", value: "\(appState.counterState.totalOperations)")
                    LabeledContent("Total Posts Loaded", value: "\(appState.postsState.posts.count)")
                    LabeledContent("Favorite Posts", value: "\(appState.postsState.posts.filter(\.isFavorite).count)")
                }
            }
            .navigationTitle("Profile & State")
            .onAppear {
                usernameInput = userState.username
                emailInput = userState.email
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(ObservableStore(store: mainStore))
}
