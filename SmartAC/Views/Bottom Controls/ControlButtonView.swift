//
//  ControlButtonView.swift
//  SmartAC
//
//  Created by Wind Versi on 21/6/22.
//

import SwiftUI

struct ControlButtonView: View {
    // MARK: - Properties
    var icon: Icons
    var action: () -> Void = {}
    
    var color: Color
    var backgroundColor: Color
    
    var isDisabled = false
    let length: CGFloat = 70

    // MARK: - Body
    var body: some View {
        Button(action: action) {
            
            ZStack {
                
                icon.image
                    .resizable()
                    .foregroundColor(color)
                
            } //: ZStack
            .frame(
                width: length,
                height: length
            )
            .background(
                backgroundColor.opacity(isDisabled ? 0.05 : 0.5)
            )
            .clipShape(Circle())
            .overlay(
                Circle()
                    .strokeBorder(lineWidth: 0.5)
                    .foregroundColor(color.opacity(0.1))
            )
            
        } //: Button
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.5 : 1)
    }
}

// MARK: - Preview
struct ControlButtonView_Previews: PreviewProvider {
    static var appTheme = AppTheme(theme: .hot)
    static var onPrimary = appTheme.onPrimary
    static var background = appTheme.background
    
    static var previews: some View {
        
        Group {
            ControlButtonView(
                icon: .power,
                color: onPrimary,
                backgroundColor: background
            )
                .previewDisplayName("Power")
            
            ControlButtonView(
                icon: .cool,
                color: onPrimary,
                backgroundColor: background
            )
                .previewDisplayName("Cool")
            
            ControlButtonView(
                icon: .fan,
                color: onPrimary,
                backgroundColor: background
            )
                .previewDisplayName("Fan")

        }
        .padding()
        .background(Color.white)
        .previewLayout(.sizeThatFits)
    }
}
