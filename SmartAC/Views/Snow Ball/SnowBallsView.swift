//
//  SnowBallsView.swift
//  SmartAC
//
//  Created by Wind Versi on 21/6/22.
//

import SwiftUI

struct BallOffset: Identifiable {
    typealias Offset = (x: CGFloat, y: CGFloat)
    var id = UUID().uuidString
    var offset: Offset
}

struct SnowBallsView: View {
    // MARK: - Properties
    @State var ballsYOffset = -(UIScreen.main.bounds.height / 2)
    
    let ballsPosition: [BallOffset] = [
        .init(offset: (x: 30, y: 90)),
        .init(offset: (x: 334, y: 102)),
        .init(offset: (x: 131, y: 191)),
        .init(offset: (x: 30, y: 272)),
        .init(offset: (x: 63, y: 335)),
        .init(offset: (x: 294, y: 294)),
        .init(offset: (x: 331, y: 323)),
        .init(offset: (x: 84, y: 521)),
        .init(offset: (x: 350, y: 604)),
        .init(offset: (x: 78, y: 687)),
        .init(offset: (x: 259, y: 681))
    ]

    // MARK: - Body
    var body: some View {
        ZStack {
            Group {
                ForEach(ballsPosition) { position in
                    let offset = position.offset
                    SnowBallView()
                        .offset(
                            x: offset.x,
                            y: offset.y
                        )
                }
            }
            .offset(y: ballsYOffset)
        }
        .fillMaxSize(alignment: .topLeading)
        .onAppear {
            print("onAppear balls")
            withAnimation(
                .linear(duration: 50.0)
                .repeatForever(autoreverses: false)
            ) {
                ballsYOffset = 1.8 * UIScreen.main.bounds.height
            }
        }
    }
}

// MARK: - Preview
struct SnowBallsView_Previews: PreviewProvider {
    static var previews: some View {
        SnowBallsView()
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Colors.coldBackground.color)
    }
}
