//
//  ContentView.swift
//  UnitConversions
//
//  Created by CHIARELLO Berardino - ADECCO on 21/04/23.
//

import SwiftUI

struct UnitConversions: View {
    
    @State private var originalData: Double = 0.0
    @State private var selectedVolumeUnit: Int = 1
    @State private var volumeToConvert: Int = 1
    @FocusState private var isFocused: Bool
    let volumeUnits : [String] = ["milliliters", "liters", "cups", "pints", "gallons"]
    
    var yourValueToLiter : Double {
        var value : Double
        switch selectedVolumeUnit {
        case 0:
            value = originalData / 1000
        case 1:
            value = originalData
        case 2:
            value = originalData * 0.2365882365
        case 3:
            value = originalData * 0.473176473
        case 4:
            value = originalData * 3.785412
        default:
            value = 0
        }
        return value
    }
    
    var convertedValue : Double {
        var value : Double
        switch volumeToConvert {
        case 0:
            value = yourValueToLiter * 1000
        case 1:
            value = yourValueToLiter
        case 2:
            value = yourValueToLiter / 0.2365882365
        case 3:
            value = yourValueToLiter / 0.473176473
        case 4:
            value = yourValueToLiter / 3.785412
        default:
            value = 0
        }
        return value
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Enter your data to convert", value: $originalData, format: .number )
                } header: {
                    Text("Data to convert")
                }
                .keyboardType(.decimalPad)
                .focused($isFocused)
                
                Section{
                    Picker ("Your data unit", selection: $selectedVolumeUnit) {
                        ForEach(0..<5) {
                            Text("\(volumeUnits[$0])")
                        }
                    }
                    Picker("Unit to be converted", selection: $volumeToConvert) {
                        ForEach(0..<5) {
                            Text("\(volumeUnits[$0])")
                        }
                    }
                }
                
                Section{
                    Text(convertedValue.formatted())
                } header: {
                    Text("Converted value")
                }
                
                
            }
            
            .navigationTitle("UnitConversions")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        isFocused = false
                    }
                }
            }
        }
    }
}

struct UnitConversions_Previews: PreviewProvider {
    static var previews: some View {
        UnitConversions()
            .environment(\.locale, Locale(identifier: "ar_MA"))
    }
}

