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
    @Binding var isCoolOn: Bool
    @Binding var isFanOn: Bool

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
                action: {
                    withAnimation {
                        isCoolOn.toggle()
                    }
                },
                color: appTheme.onPrimary,
                backgroundColor: appTheme.background,
                isDisabled: !isTurnedOn || appTheme.theme != .cold
            )
                .fillMaxWidth()
            
            ControlButtonView(
                icon: .fan,
                action: {
                    withAnimation {
                        isFanOn.toggle()
                    }
                },
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
            isTurnedOn: .constant(false),
            isCoolOn: .constant(false),
            isFanOn: .constant(false)
        )
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.white)
    }
}
