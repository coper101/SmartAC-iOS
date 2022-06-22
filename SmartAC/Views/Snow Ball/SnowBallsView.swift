//
//  SnowBallsView.swift
//  SmartAC
//
//  Created by Wind Versi on 21/6/22.
//

import SwiftUI

struct BallOffset: Identifiable {
    typealias Offset = (x: CGFloat, y: CGFloat)
    var offset: Offset
    var id: String {
        "\(offset.x)\(offset.y)"
    }
}

struct SnowBallsView: View {
    // MARK: - Properties
    var isCoolOn: Bool
    
    @State var ballsPosition: [BallOffset] = [
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
            
            ForEach(ballsPosition) { position in
                let offset = position.offset
                SnowBallView(
                    offset: (
                        x: offset.x,
                        y: offset.y
                    )
                )
                    .transition(.opacity)
            }
            
        } //: ZStack
        .fillMaxSize(alignment: .topLeading)
        .onChange(of: isCoolOn) { isOn in
            
            guard isOn else {
                ballsPosition.removeSubrange(
                    (ballsPosition.count - 6)..<ballsPosition.count
                )
                return
            }
            
            let offsetsToAdd: [BallOffset] = [
                .init(offset: (x: 294 + 10, y: 294 - 10)),
                .init(offset: (x: 331 - 10, y: 323 - 10)),
                .init(offset: (x: 84 - 10, y: 521 + 10)),
                .init(offset: (x: 350 - 15, y: 604 - 10)),
                .init(offset: (x: 78 + 13, y: 687 - 10)),
                .init(offset: (x: 259 - 10, y: 681 + 13))
            ]
            
            withAnimation(.linear(duration: 4)) {
                ballsPosition.append(contentsOf: offsetsToAdd)
            }
        }
        
    }
}

// MARK: - Preview
struct SnowBallsView_Previews: PreviewProvider {
    static var previews: some View {
        SnowBallsView(isCoolOn: false)
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Colors.coldBackground.color)
    }
}
