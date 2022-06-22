//
//  AppView.swift
//  SmartAC
//
//  Created by Wind Versi on 21/6/22.
//

import SwiftUI

struct AppView: View {
    // MARK: - Properties
    @EnvironmentObject var tempModelData: TempModelData

    var appTheme: AppTheme {
        tempModelData.appTheme
    }
    
    var content: some View {
        VStack(spacing: 0) {
            
            Spacer()
            
            // Row 1: TEMP DISPLAY
            TempDisplayView(
                temperature: $tempModelData.temperature,
                appTheme: tempModelData.appTheme,
                isTurnedOn: tempModelData.isTurnedOn
            )
                .padding(.bottom, 30)
                        
            // Row 2: TEMP SLIDER
            TempSliderView(
                temperature: $tempModelData.temperature,
                appTheme: tempModelData.appTheme,
                isTurnedOn: tempModelData.isTurnedOn
            )
            
            Spacer()
            
            // Row 3: BOTTOM CONTROLS
            BottomControlsView(
                appTheme: tempModelData.appTheme,
                isTurnedOn: $tempModelData.isTurnedOn,
                isCoolOn: $tempModelData.isCoolOn,
                isFanOn: $tempModelData.isFanOn
            )
                .padding(.horizontal, 21)
                .padding(.bottom, 21)
            
        } //: VStack
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            
            // Layer 1: SMOKE
            if tempModelData.isTurnedOn && tempModelData.isFanOn {
                SmokeView()
                    .zIndex(0)
            }
            
            // Layer 2: SNOWBALLS
            if appTheme.theme == .cold && tempModelData.isTurnedOn {
                SnowBallsView(isCoolOn: tempModelData.isCoolOn)
                    .zIndex(1)
            }
            
            // Layer 3: CONTENT
            content
                .zIndex(2)
            
        } //: ZStack
        .fillMaxSize()
        .background(
            LinearGradient(
                colors: [
                    appTheme.background,
                    appTheme.lightBackground
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .onChange(
            of: tempModelData.isTurnedOn,
            perform: changeToInactive
        )
        .onChange(
            of: tempModelData.temperature.kelvinValue,
            perform: changeThemeAccordToTemp
        )
    }
    
    // MARK: - Functions
    func changeToInactive(isTurnedOn: Bool) {
        guard isTurnedOn else {
            withAnimation {
                tempModelData.appTheme.theme = .inactive
            }
            return
        }
        changeThemeAccordToTemp(tempModelData.temperature.kelvinValue)
    }
    
    func changeThemeAccordToTemp(_ tempKelvin: Double) {
        let tempCelsius = tempKelvin.kelvinToCelsius()
        let minTempCelsius = TempConstant.minTempCelsius
        let maxTempCelsius = TempConstant.maxTempCelsius
        let halfTempDifferenceCelsius = TempConstant.tempDifferentCelsius / 2

        let coldRange = minTempCelsius...(minTempCelsius + halfTempDifferenceCelsius)
        let hotRange = (maxTempCelsius - (halfTempDifferenceCelsius - 1))...maxTempCelsius
        
        if hotRange.contains(tempCelsius) && appTheme.theme != .hot {
            print("change to hot")
            withAnimation(.easeInOut) {
                tempModelData.appTheme.theme = .hot
            }
        } else if coldRange.contains(tempCelsius) && appTheme.theme != .cold {
            withAnimation(.easeInOut) {
                print("change to cold")
                tempModelData.appTheme.theme = .cold
            }
        }
        
        print(
            """
                tempCelsius: \(tempCelsius)
                coldRange: \(coldRange)
                hotRange: \(hotRange)
                isTurnedOn: \(tempModelData.isTurnedOn)
                appTheme: \(appTheme.theme)
                
                """
        )
    }
}

// MARK: - Preview
struct AppView_Previews: PreviewProvider {
    
    static func generateModelData(_ theme: Theme) -> TempModelData {
        let tempModelData = TempModelData()
        tempModelData.appTheme.theme = theme
        tempModelData.isTurnedOn = theme == .hot || theme == .cold
        return tempModelData
    }
    
    static var previews: some View {
        
        ForEach(Theme.allCases) { theme in
            AppView()
                .environmentObject(generateModelData(theme))
                .previewDisplayName("\(theme.rawValue) theme")
        }
    }
    
}
