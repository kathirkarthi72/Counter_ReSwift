//
//  CounterActions.swift
//  Learn ReSwift
//
//  ReSwift Concept: ACTIONS
//  -----------------------
//  Actions represent intent to change state.
//  In ReSwift, actions conform to the `Action` protocol.
//  They carry minimal payloads describing state mutations.
//

import Foundation
import ReSwift

public enum CounterAction: Action {
    case increment
    case decrement
    case reset
    case setStep(Int)
}
