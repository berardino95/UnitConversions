//
//  UnitConversions .swift
//  UnitConversions
//
//  Created by CHIARELLO Berardino - ADECCO on 22/04/23.
//

import SwiftUI

struct UnitConversionsWithMeasurements: View {
    
    @State private var yourValue: Double = 0
   
    var measurementValue : Measurement<UnitTemperature> { Measurement(value: yourValue, unit: UnitTemperature.celsius)}
    
    enum temperature : UnitTemperature {
        case 
    }
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Your value", value: $yourValue, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section{
                    Text("\(measurementValue)")
                }
            }
        }
    }
}

struct UnitConversionsWithMeasurements_Previews: PreviewProvider {
    static var previews: some View {
        UnitConversionsWithMeasurements()
    }
}
