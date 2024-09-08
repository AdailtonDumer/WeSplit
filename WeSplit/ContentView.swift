//
//  ContentView.swift
//  WeSplit
//
//  Created by Adailton Lucas on 05/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var checkAmountIsFocused : Bool
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    let defaultCurrency = Locale.current.currency?.identifier ?? "BRL"
    
    var totalPerPerson : Double {
        let dNumberOfPeople = Double(numberOfPeople)
        let dtipPercentage = Double(tipPercentage)
        
        let tipAmount = (checkAmount / 100) * dtipPercentage
        
        return (checkAmount + tipAmount) / dNumberOfPeople
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Informe o valor gasto", value: $checkAmount, format: .currency(code: defaultCurrency))
                        .keyboardType(.decimalPad)
                        .focused($checkAmountIsFocused)
                    
                    Picker("Número de pessoas", selection: $numberOfPeople){
                        ForEach(2..<100, id: \.self){
                            Text("\($0) Pessoas")
                        }
                    }
                }
                Section("Gorjeta"){
                    Picker("Gorjeta:", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Valor por pessoa:"){
                    Text(totalPerPerson, format: .currency(code: defaultCurrency))
                        .foregroundStyle(tipPercentage == 0 ? .red : .primary)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if checkAmountIsFocused {
                    Button("Done"){
                        checkAmountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
