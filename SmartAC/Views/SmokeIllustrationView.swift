//
//  SmokeIllustrationView.swift
//  SmartAC
//
//  Created by Wind Versi on 21/6/22.
//

import SwiftUI

struct SmokeIllustrationView: View {
    // MARK: - Properties
    var color: Color

    // MARK: - Body
    var body: some View {
        Icons.smoke.image
            .resizable()
            .foregroundColor(color)
            .scaledToFit()
            .rotationEffect(.init(degrees: -5))
    }
}

// MARK: - Preview
struct SmokeIllustrationView_Previews: PreviewProvider {
    static var previews: some View {
        SmokeIllustrationView(
            color: Colors.primary.color.opacity(0.45)
        )
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Colors.hotBackground.color)
    }
}
