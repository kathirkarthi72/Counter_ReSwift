//
//  CounterView.swift
//  Learn ReSwift
//
//  View displaying Synchronous ReSwift state mutations.
//

import SwiftUI

struct CounterView: View {
    @EnvironmentObject var store: ObservableStore<AppState>
    
    private var counterState: CounterState {
        store.state.counterState
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                // Info Card
                VStack(spacing: 8) {
                    Text("ReSwift Sync Action")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                    
                    Text("Pure Counter State")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Every button press dispatches a synchronous `CounterAction` to the store.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(16)
                
                Spacer()
                
                // Display Counter Value
                VStack(spacing: 6) {
                    Text("\(counterState.value)")
                        .font(.system(size: 72, weight: .bold, design: .rounded))
                        .foregroundStyle(counterState.value >= 0 ? Color.blue : Color.red)
                    
                    Text("Total Operations: \(counterState.totalOperations)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding()
                
                // Action Buttons
                HStack(spacing: 20) {
                    Button(action: {
                        store.dispatch(CounterAction.decrement)
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(.red)
                    }
                    
                    Button(action: {
                        store.dispatch(CounterAction.reset)
                    }) {
                        Text("Reset")
                            .font(.headline)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                    }
                    
                    Button(action: {
                        store.dispatch(CounterAction.increment)
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(.green)
                    }
                }
                
                // Step Control Picker
                VStack(spacing: 10) {
                    Text("Step Multiplier: \(counterState.step)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Stepper(value: Binding(
                        get: { counterState.step },
                        set: { newStep in store.dispatch(CounterAction.setStep(newStep)) }
                    ), in: 1...10) {
                        Text("Change Step Size")
                    }
                    .padding(.horizontal, 32)
                }
                .padding()
                .background(Color(.tertiarySystemBackground))
                .cornerRadius(12)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Counter (Sync)")
        }
    }
}

#Preview {
    CounterView()
        .environmentObject(ObservableStore(store: mainStore))
}
