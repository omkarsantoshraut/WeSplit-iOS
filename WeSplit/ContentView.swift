import SwiftUI

@available(iOS 15.0, *)
struct ContentView: View {
    @State private var checkoutAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isAmountFieldFocoused: Bool
    
    private let tipPercentageOptions = Array(0...100)
    private let currency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tip = checkoutAmount * tipSelection / 100.0
        return checkoutAmount + tip
    }
    
    var amountPerPerson: Double {
        let people = Double(numberOfPeople + 2)
        return totalAmount/people
    }

    var body: some View {
        

        NavigationView {
            Form {
                Section {
                    TextField("Enter Amount", value: $checkoutAmount, format: currency).keyboardType(.decimalPad).focused($isAmountFieldFocoused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentageOptions, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave ?")
                }
                
                Section {
                    Text(amountPerPerson, format: currency)
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(totalAmount, format: currency)
                } header: {
                    Text("Total amount")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        isAmountFieldFocoused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            ContentView()
        } else {
            // Fallback on earlier versions
            // no-op
        }
    }
}
