//
//  TempModelData.swift
//  SmartAC
//
//  Created by Wind Versi on 21/6/22.
//

import SwiftUI

// Themes:
// inactive - white + black (off)
// hot - orange + white (on - 25 to 30)
// cold - blue + white (on - 16 to 22)

enum Theme: String, CaseIterable, Identifiable {
    case inactive
    case hot
    case cold
    var id: String {
        self.rawValue
    }
}

struct AppTheme {
    var theme: Theme
    var background: Color {
        switch theme {
        case .inactive:
            return Colors.primary.color
        case .hot:
            return Colors.hotBackground.color
        case .cold:
            return Colors.coldBackground.color
        }
    }
    var lightBackground: Color {
        switch theme {
        case .inactive:
            return Colors.primary.color
        case .hot:
            return Colors.hotLightBackground.color
        case .cold:
            return Colors.coldLightBackground.color
        }
    }
    var onPrimary: Color {
        switch theme {
        case .inactive:
            return Colors.onPrimary.color
        case .hot:
            return Colors.primary.color
        case .cold:
            return Colors.primary.color
        }
    }
}

struct TempConstant {
    static let minTempCelsius = 16.0
    static let maxTempCelsius = 30.0
    static let tempDifferentCelsius = 14.0
}

class TempModelData: ObservableObject {
    
    @Published var isTurnedOn = false
    
    @Published var temperature: Temperature = .init(
        kelvinValue: TempConstant.minTempCelsius.celsiusToKelvin(),
        unit: .celsius
    )
    
    @Published var appTheme: AppTheme = .init(theme: .inactive)
    
}
