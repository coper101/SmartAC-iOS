//
//  SnowBallsView.swift
//  SmartAC
//
//  Created by Wind Versi on 21/6/22.
//

import SwiftUI

struct SnowBallView: View {
    // MARK: - Properties
    let length: CGFloat = 12

    // MARK: - Body
    var body: some View {
        Circle()
            .fill(
                RadialGradient(
                    colors: [
                        Colors.primary.color.opacity(0.5),
                        Colors.primary.color.opacity(0.2),
                    ],
                    center: UnitPoint(x: 0.3, y: 0.3),
                    startRadius: 1,
                    endRadius: 0.7 * length
                )
            )
            .frame(
                width: length,
                height: length
            )
            .transition(.opacity)
    }
}

// MARK: - Preview
struct SnowBallView_Previews: PreviewProvider {
    static var previews: some View {
        SnowBallView()
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Colors.coldBackground.color)
    }
}
