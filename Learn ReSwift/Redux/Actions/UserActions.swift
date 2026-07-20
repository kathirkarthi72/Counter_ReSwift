//
//  UserActions.swift
//  Learn ReSwift
//
//  ReSwift Actions for Profile & Settings state changes.
//

import Foundation
import ReSwift

public enum UserAction: Action {
    case updateProfile(username: String, email: String)
    case toggleDarkMode
    case toggleNotifications
}
