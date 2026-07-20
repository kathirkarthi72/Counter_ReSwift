//
//  CounterReducer.swift
//  Learn ReSwift
//
//  ReSwift Concept: REDUCER
//  ------------------------
//  A reducer is a pure function: (Action, State?) -> State
//  - It MUST NOT make network calls, read disk, or cause side-effects.
//  - It takes the current state and action, returning a NEW modified state copy.
//

import Foundation
import ReSwift

public func counterReducer(action: Action, state: CounterState?) -> CounterState {
    var state = state ?? CounterState()
    
    guard let action = action as? CounterAction else {
        return state
    }
    
    switch action {
    case .increment:
        state.value += state.step
        state.totalOperations += 1
        
    case .decrement:
        state.value -= state.step
        state.totalOperations += 1
        
    case .reset:
        state.value = 0
        state.totalOperations += 1
        
    case .setStep(let newStep):
        state.step = max(1, newStep)
    }
    
    return state
}
