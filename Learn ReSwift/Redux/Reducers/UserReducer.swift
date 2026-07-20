//
//  UserReducer.swift
//  Learn ReSwift
//
//  Pure Reducer handling `UserState` updates.
//

import Foundation
import ReSwift

public func userReducer(action: Action, state: UserState?) -> UserState {
    var state = state ?? UserState()
    
    guard let action = action as? UserAction else {
        return state
    }
    
    switch action {
    case .updateProfile(let username, let email):
        state.username = username
        state.email = email
        
    case .toggleDarkMode:
        state.isDarkMode.toggle()
        
    case .toggleNotifications:
        state.notificationsEnabled.toggle()
    }
    
    return state
}
