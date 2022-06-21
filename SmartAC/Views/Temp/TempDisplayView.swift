//
//  TempDisplayView.swift
//  SmartAC
//
//  Created by Wind Versi on 21/6/22.
//

import SwiftUI

extension Double {
    func toWholeNumber() -> Int {
        Int(self)
    }
}

enum TempUnit: String {
    case fahrenheit = "F"
    case celsius = "C"
    var unitSymbol: String {
        "°\(self.rawValue)"
    }
}

extension Double {
    func kelvinToFahrenheit() -> Double {
        (self - 273.15) * 9/5 + 32
    }
    func kelvinToCelsius() -> Double {
        self - 273.15
    }
    func celsiusToKelvin() -> Double {
        self + 273.15
    }
}

struct Temperature {
    // default to kelvin unit
    var kelvinValue: Double
    var unit: TempUnit
    var convertedValue: Double {
        switch unit {
        case .fahrenheit:
            return kelvinValue.kelvinToFahrenheit()
        case .celsius:
            return kelvinValue.kelvinToCelsius()
        }
    }
}

struct TempDisplayView: View {
    // MARK: - Properties
    @Binding var temperature: Temperature
    var appTheme: AppTheme
    var isTurnedOn: Bool
    
    var onPrimary: Color {
        appTheme.onPrimary
    }
    
    var background: Color {
        appTheme.background
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 18) {
            
            // Col 1:
            Text("\(temperature.convertedValue.toWholeNumber())")
                .textStyle(
                    foregroundColor: onPrimary,
                    size: 75
                )
            
            // Col 2: Unit Toggle
            VStack(spacing: 0) {
                
                // Row 1: Celsius
                Button(action: didTapCelsius) {
                    Text("\(TempUnit.celsius.unitSymbol)")
                        .textStyle(
                            foregroundColor: onPrimary,
                            size: 30
                        )
                        .opacity(temperature.unit == .celsius ? 1 : 0.3)
                }
                .disabled(!isTurnedOn)
                
                // Row 2: Fahrenheit
                Button(action: didTapFahrenheit) {
                    Text("\(TempUnit.fahrenheit.unitSymbol)")
                        .textStyle(
                            foregroundColor: onPrimary,
                            size: 30
                        )
                        .opacity(temperature.unit == .fahrenheit ? 1 : 0.3)
                }
                .disabled(!isTurnedOn)
                
            } //: VStack
        
        } //: HStack
        .opacity(isTurnedOn ? 1 : 0.7)
    }
    
    // MARK: - Functions
    func didTapCelsius() {
        withAnimation {
            temperature.unit = .celsius
        }
    }
    
    func didTapFahrenheit() {
        withAnimation {
            temperature.unit = .fahrenheit
        }
    }
    
}

// MARK: - Preview
struct TempDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        TempDisplayView(
            temperature: .constant(sampleTemp),
            appTheme: .init(theme: .inactive),
            isTurnedOn: false
        )
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

