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
    
    @State var smokeXOffset: CGFloat = -(UIScreen.main.bounds.width * 1.2)
    @State var smokeScale: CGFloat = 1.3
    
    @State var smoke2XOffset: CGFloat = -(UIScreen.main.bounds.width * 0.5)
    
    var smokeColor: Color {
        tempModelData.appTheme.onPrimary.opacity(0.4)
    }

    
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
                isTurnedOn: $tempModelData.isTurnedOn
            )
                .padding(.horizontal, 21)
                .padding(.bottom, 21)
            
        } //: VStack
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            
            // Layer 1: SMOKE &/OR SNOW
            if tempModelData.isTurnedOn {
                
                SmokeIllustrationView(color: smokeColor)
                    .scaleEffect(smokeScale)
                    .offset(x: smoke2XOffset, y: -500)
                    .offset(x: 0.5)
                    .transition(.opacity)
                    .onAppear {
                        withAnimation(
                            .linear(duration: 40.0)
                            .repeatForever(autoreverses: false)
                        ) {
                            smoke2XOffset = (UIScreen.main.bounds.width) * 1.2
                        }
                    }
                
                SmokeIllustrationView(color: smokeColor)
                    .scaleEffect(smokeScale)
                    .offset(x: smoke2XOffset, y: 500)
                    .offset(x: 0.5)
                    .transition(.opacity)
                    .onAppear {
                        withAnimation(
                            .linear(duration: 35.0)
                            .repeatForever(autoreverses: false)
                        ) {
                            smoke2XOffset = (UIScreen.main.bounds.width) * 1.2
                        }
                    }
                    
                
                SmokeIllustrationView(color: smokeColor)
                    .scaleEffect(smokeScale)
                    .offset(x: smokeXOffset)
                    .transition(.opacity)
                    .onAppear {
                        withAnimation(
                            .linear(duration: 30.0)
                            .repeatForever(autoreverses: false)
                        ) {
                            smokeXOffset = (UIScreen.main.bounds.width) * 1.5
                            smokeScale = 2.4
                        }
                    }
                
            }
            
            // Layer 2 SNOWBALLS
            if appTheme.theme == .cold {
                SnowBallsView()
                    .zIndex(1)
            }
            
            // Layer 3: CONTENT
            content
                .zIndex(2)
            
        }
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
        .onChange(of: tempModelData.isTurnedOn) { isOn in
            guard isOn else {
                withAnimation {
                    tempModelData.appTheme.theme = .inactive
                }
                return
            }
            changeThemeAccordToTemp(tempModelData.temperature.kelvinValue)
        }
        .onChange(
            of: tempModelData.temperature.kelvinValue,
            perform: changeThemeAccordToTemp
        )
    }
    
    // MARK: - Functions
    func changeThemeAccordToTemp(_ tempKelvin: Double) {
        let tempCelsius = tempKelvin.kelvinToCelsius()
        let minTempCelsius = TempConstant.minTempCelsius
        let maxTempCelsius = TempConstant.maxTempCelsius
        let halfTempDifferenceCelsius = TempConstant.tempDifferentCelsius / 2

        let coldRange = minTempCelsius...(minTempCelsius + halfTempDifferenceCelsius)
        let hotRange = (maxTempCelsius - halfTempDifferenceCelsius)...maxTempCelsius
        
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
