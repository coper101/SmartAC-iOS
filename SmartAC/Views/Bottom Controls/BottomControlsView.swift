//
//  BottomControlsView.swift
//  SmartAC
//
//  Created by Wind Versi on 21/6/22.
//

import SwiftUI

struct BottomControlsView: View {
    // MARK: - Properties
    var appTheme: AppTheme
    @Binding var isTurnedOn: Bool

    // MARK: - Body
    var body: some View {
        HStack(spacing: 0) {
            
            ControlButtonView(
                icon: .power,
                action: {
                    withAnimation {
                        isTurnedOn.toggle()
                    }
                },
                color: appTheme.onPrimary,
                backgroundColor: appTheme.background
            )
                .fillMaxWidth()
            
            ControlButtonView(
                icon: .cool,
                color: appTheme.onPrimary,
                backgroundColor: appTheme.background,
                isDisabled: !isTurnedOn
            )
                .fillMaxWidth()
            
            ControlButtonView(
                icon: .fan,
                color: appTheme.onPrimary,
                backgroundColor: appTheme.background,
                isDisabled: !isTurnedOn
            )
                .fillMaxWidth()
            
        } //: HStack
        .fillMaxWidth()
    }
}

// MARK: - Preview
struct BottomControlsView_Previews: PreviewProvider {
    static var previews: some View {
        BottomControlsView(
            appTheme: .init(theme: .inactive),
            isTurnedOn: .constant(false)
        )
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.white)
    }
}
