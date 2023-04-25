//
//  ContentView.swift
//  UnitConversions
//
//  Created by CHIARELLO Berardino - ADECCO on 21/04/23.
//

import SwiftUI

struct UnitConversions: View {
    
//    enum TypeofUnit : String, CaseIterable, Identifiable {
//        case length, volume
//        var id: Self { self }
//    }
    
    enum TypeofUnit : String, CaseIterable, Identifiable {
        case length, volume
        var id: Self { self }
        
        var unitArray : [String] {
            switch self {
            case .length :
                return ["millimeters", "meters"]
            case.volume :
                return ["milliliters", "liters", "cups", "pints", "gallons"]
            }
        }
    }
    
    @State private var originalData: Double = 0
    @State private var selectedVolumeUnit: String = TypeofUnit.length.unitArray[0]
    @State private var volumeToConvert: String = TypeofUnit.length.unitArray[0]
    @State private var selectedTypeOfUnit : TypeofUnit = .length
    @FocusState private var isFocused: Bool
    
    //Main unit is Meters, Liters ecc...
    var yourValueToMainUnit : Double {
        var value : Double
        switch selectedVolumeUnit {
        case "milliliters":
            value = originalData / 1000
        case "liters":
            value = originalData
        case "cups":
            value = originalData * 0.2365882365
        case "pints":
            value = originalData * 0.473176473
        case "gallons":
            value = originalData * 3.785412
        case "millimeters" :
            value = originalData / 1000
        case "meters" :
            value = originalData * 1
        default:
            value = 0
        }
        return value
    }
    
    var convertedValue : Double {
        var value : Double
        switch volumeToConvert {
        case "milliliters":
            value = yourValueToMainUnit * 1000
        case "liters":
            value = yourValueToMainUnit
        case "cups":
            value = yourValueToMainUnit / 0.2365882365
        case "pints":
            value = yourValueToMainUnit / 0.473176473
        case "gallons":
            value = yourValueToMainUnit / 3.785412
        case "millimeters":
            value = yourValueToMainUnit * 1000
        case "meters" :
            value = yourValueToMainUnit * 1
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
                .onTapGesture {
                    originalData = Double()
                }
                
                Section{
                    Picker("Type of unit", selection: $selectedTypeOfUnit) {
                        ForEach (TypeofUnit.allCases) { unit in
                            Text(unit.rawValue.capitalized)
                        }
                    }
                    Picker ("Your data unit", selection: $selectedVolumeUnit) {
                        ForEach(selectedTypeOfUnit.unitArray, id: \.self) {unit in
                            Text("\(unit.capitalized)")
                        }
                    }
                    Picker("Unit to be converted", selection: $volumeToConvert) {
                        ForEach(selectedTypeOfUnit.unitArray, id: \.self) { unit in
                            Text("\(unit.capitalized)")
                        }
                    }
                }
                
                Section{
                    Text(selectedVolumeUnit.isEmpty || volumeToConvert.isEmpty ? "0" : convertedValue.formatted())
                } header: {
                    Text("Convert \(selectedVolumeUnit) to \(volumeToConvert)")
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

