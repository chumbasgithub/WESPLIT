//
//  ContentView.swift
//  WeSplit
//
//  Created by Chumba Kiplagat on 5/21/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @State private var taxPercentage = 0.0
    @State private var useRedText = false
    @FocusState private var amountIsFocused: Bool
    
    var taxandtotal : Double{
        let taxAmount = Double(taxPercentage)
        let calculateTax = checkAmount * taxAmount
        let taxIncluded = checkAmount + calculateTax
        return taxIncluded
    }
    let tipPecentages = 0
    
    
    var totalPerPerson : Double{
        // Calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2
        )
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        
        let grandTotal = taxandtotal + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var total: Double{
        let tipSelect = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelect
        let totalAmount = taxandtotal + tipValue
        return totalAmount
        
    }
    var body: some View {
        NavigationStack{
            Form {
                
                Section("Check Amount, Tax, Total with tax"){
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    TextField("Tax",value:$taxPercentage, format: .percent)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Text(taxandtotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<11){
                            Text("\($0) people")
                        }
                    }
                }
                Section("How much do you want to tip"){
                    Picker("Tip percentage", selection:  $tipPercentage){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                Section("Total amount with tip and tax included"){
                    Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? Color.red : Color.black)
                }
                Section("Cost per person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            
            .navigationTitle("WeSplit")
            .toolbar{
                if amountIsFocused{
                    Button("Done"){
                        amountIsFocused = false
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

