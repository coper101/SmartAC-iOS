//
//  SnowBallsView.swift
//  SmartAC
//
//  Created by Wind Versi on 21/6/22.
//

import SwiftUI

struct SnowBallView: View {
    // MARK: - Properties
    @State var ballsYOffset = -(ScreenSize.height / 2)

    @State var offset: (x: CGFloat, y: CGFloat)
    @State var heightTrans: CGFloat = .zero
    @State var widthTrans: CGFloat = .zero
    
    let length: CGFloat = 12
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                let trans = value.translation
                let newHeight = trans.height
                let newWidth = trans.width
                
                let amountChangeHeight = newHeight - heightTrans
                let amountChangeWidth = newWidth - widthTrans
                
                heightTrans = newHeight
                widthTrans = newWidth
                
                offset.x += amountChangeWidth
                offset.y += amountChangeHeight
            }
            .onEnded { _ in
                heightTrans = .zero
                widthTrans = .zero
            }
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            
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
                .offset(
                    x: offset.x,
                    y: offset.y + ballsYOffset
                )
                .transition(.opacity)
                .gesture(drag)
            
        } //: ZStack
        .fillMaxSize(alignment: .topLeading)
        .onAppear {
            withAnimation(
                .linear
                .speed(0.01)
                .repeatForever(autoreverses: false)
            ) {
                ballsYOffset = 1.4 * ScreenSize.height
            }
        }
    }
}

// MARK: - Preview
struct SnowBallView_Previews: PreviewProvider {
    static var previews: some View {
        SnowBallView(offset: (x: 131, y: 200))
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Colors.coldBackground.color)
    }
}
