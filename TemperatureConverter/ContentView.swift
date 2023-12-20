//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Caroline Ankjær Andersen on 20/12/2023.
//

import SwiftUI

enum TempType: CaseIterable {
	case fahrenheit, celcius, kelvin
}

struct ContentView: View {
	@State private var inputTemperature = 0.0
	
	@State private var inputUnit: TempType = .celcius
	@State private var outputUnit: TempType = .celcius
	
	@FocusState private var inputTemperatureIsFocused: Bool
	
	var convertedTemperature: Double {
		var temperatureInCelcius = 0.0
		
		switch inputUnit {
			case .fahrenheit:
				temperatureInCelcius = (inputTemperature - 32) * 5 / 9
			case .kelvin:
				temperatureInCelcius = inputTemperature - 273.15
			default:
				temperatureInCelcius = inputTemperature
		}
		
		switch outputUnit {
			case .fahrenheit:
				return temperatureInCelcius * 9 / 5 + 32
			case .kelvin:
				return temperatureInCelcius + 237.15
			default:
				return temperatureInCelcius
		}
	}
	
    var body: some View {
		NavigationStack {
			Form {
				Section("Input temperature") {
					TextField("Enter temperature", value: $inputTemperature, format: .number)
						.keyboardType(.decimalPad)
						.focused($inputTemperatureIsFocused)
				}
				
				Section {
					Picker("From", selection: $inputUnit) {
						ForEach(TempType.allCases, id: \.self) {
							Text(String(describing: $0))
						}
					}
					Picker("To", selection: $outputUnit) {
						ForEach(TempType.allCases, id: \.self) {
							Text(String(describing: $0))
						}
					}
				}
				
				Section("Converted temperature") {
					Text(String(describing: convertedTemperature))
				}
			}
			.navigationTitle("Temp Convertion")
			.toolbar {
				if inputTemperatureIsFocused {
					Button("Done") {
						inputTemperatureIsFocused = false
					}
				}
			}
		}
    }
}

#Preview {
    ContentView()
}
