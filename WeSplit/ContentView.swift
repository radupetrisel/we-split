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
    
    private let tipPercentages = [0, 5, 10, 15, 20, 25]
    
    private var totalPerPerson: Double {
        total / Double(numberOfPeople)
    }
    
    private var total: Double {
        checkAmount * (1 + Double(tipPercentage) / 100)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Self.currencyIdentifier))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100, id: \.self) { Text("\($0) people") }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) { Text($0, format: .percent) }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(total, format: .currency(code: Self.currencyIdentifier))
                } header: {
                    Text("Total (including tips)")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Self.currencyIdentifier))
                } header: {
                    Text("Amount per person")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
