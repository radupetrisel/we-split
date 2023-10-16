//
//  ContentView.swift
//  WeSplit
//
//  Created by Radu Petrisel on 05.07.2023.
//

import SwiftUI

struct ContentView: View {
    private static let currencyIdentifier = Locale.current.currency?.identifier ?? "RON"
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var isAmountFocused: Bool
    
    private var totalPerPerson: Double {
        total / Double(numberOfPeople)
    }
    
    private var total: Double {
        checkAmount * (1 + Double(tipPercentage) / 100)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Self.currencyIdentifier))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(1..<100, id: \.self) { Text("^[\($0) person](inflect: true)") }
                    }
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) { Text($0, format: .percent) }
                    }
                }
                
                Section("Total (including tips)") {
                    Text(total, format: .currency(code: Self.currencyIdentifier))
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Self.currencyIdentifier))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        isAmountFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
