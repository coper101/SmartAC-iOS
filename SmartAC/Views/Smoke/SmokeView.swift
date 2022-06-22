//
//  SmokeView.swift
//  SmartAC
//
//  Created by Wind Versi on 22/6/22.
//

import SwiftUI

struct SmokeView: View {
    // MARK: - Properties
    @State var smokeXOffset: CGFloat = -(ScreenSize.width * 1.2)
    @State var smoke2XOffset: CGFloat = -(ScreenSize.width * 0.5)
    @State var smokeScale: CGFloat = 1.3
    
    let duration: Double = 30
    let smokeColor = Colors.primary.color.opacity(0.4)

    // MARK: - Body
    var body: some View {
        ZStack {
                                                
            SmokeIllustrationView(color: smokeColor)
                .scaleEffect(smokeScale)
                .offset(x: smoke2XOffset, y: -500)
                .offset(x: 0.5)
                .transition(.opacity)
                .animation(
                    .linear(duration: duration + 10)
                    .repeatForever(autoreverses: false),
                    value: smoke2XOffset
                )
            
            SmokeIllustrationView(color: smokeColor)
                .scaleEffect(smokeScale)
                .offset(x: smoke2XOffset, y: 500)
                .offset(x: 0.5)
                .transition(.opacity)
                .animation(
                    .linear(duration: duration + 5)
                    .repeatForever(autoreverses: false),
                    value: smoke2XOffset
                )
            
            SmokeIllustrationView(color: smokeColor)
                .scaleEffect(smokeScale)
                .offset(x: smokeXOffset)
                .transition(.opacity)
                .animation(
                    .linear(duration: duration)
                    .repeatForever(autoreverses: false),
                    value: smoke2XOffset
                )
                            
        } //: ZStack
        .fillMaxSize()
        .onAppear {
            smoke2XOffset = (ScreenSize.width) * 1.2
            smokeXOffset = (ScreenSize.width) * 1.5
            smokeScale = 2.4
        }
    }
}

// MARK: - Preview
struct SmokeView_Previews: PreviewProvider {
    static var previews: some View {
        
        SmokeView()
            .background(AppTheme.init(theme: .hot).background)
            .previewLayout(.sizeThatFits)
        
        SmokeView()
            .background(AppTheme.init(theme: .cold).background)
            .previewLayout(.sizeThatFits)
    }
}
