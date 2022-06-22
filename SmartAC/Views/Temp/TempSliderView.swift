//
//  TempSliderView.swift
//  SmartAC
//
//  Created by Wind Versi on 21/6/22.
//

import SwiftUI

struct TempSliderView: View {
    // MARK: - Properties
    @Binding var temperature: Temperature
    var appTheme: AppTheme
    var isTurnedOn: Bool
    
    let maxHeight: CGFloat = 416
    let minHeight: CGFloat = .zero
    @State var sliderHeight: CGFloat = 100 // .zero
    @State var heightTranslation: CGFloat = .zero
    
    var onPrimary: Color {
        appTheme.onPrimary
    }
    
    var background: Color {
        appTheme.background
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                let newHeightTrans = value.translation.height

                // swiping up gives a negative value
                let isSwipedUp = newHeightTrans < heightTranslation
                    
                // amount change regardless of swipe direction
                let amountChange = abs(newHeightTrans - heightTranslation)
                
                // to track the amount change
                heightTranslation = newHeightTrans
                                                
                let newSliderHeight = isSwipedUp ?
                    sliderHeight + amountChange :
                    sliderHeight - amountChange
                
                let belowOrEqualMax = newSliderHeight <= maxHeight
                let aboveOrEqualMin = newSliderHeight >= minHeight
                
                // check if new height is in range
                guard belowOrEqualMax && aboveOrEqualMin else {
                    return
                }
                
                withAnimation(.interactiveSpring()) {
                    sliderHeight = newSliderHeight
                }

            }
            .onEnded { _ in
                heightTranslation = .zero
            }
    }
    
    var sliderfill: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            
            Path { path in
                path.move(to: .zero)
                path.addLine(to: .init(x: 0, y: height))
                path.addLine(to: .init(x: width, y: height))
                path.addLine(to: .init(x: width, y: 0))
                path.addLine(to: .init(x: width * 0.8, y: height * 0.1))
                path.addQuadCurve(
                    to: .init(x: width * 0.2, y: height * 0.1),
                    control: .init(x: width * 0.5, y: height * 0.2)
                )
                path.addLine(to: .zero)
            }
            .fill(onPrimary)
        }
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                
                sliderfill
                    .fillMaxWidth()
                    .frame(height: 50)
                
                onPrimary
                    .frame(height: sliderHeight)
                
            }
            
        } //: ZStack
        .frame(
            width: 157,
            height: maxHeight,
            alignment: .bottom
        )
        .background(onPrimary.opacity(isTurnedOn ? 0.4 : 0.1))
        .clipShape(RoundedRectangle(cornerRadius: 100))
        .gesture(drag)
        .onChange(
            of: sliderHeight,
            perform: changeSliderHeight
        )
        .disabled(!isTurnedOn)
        .opacity(isTurnedOn ? 1 : 0.5)
        
    }
    
    // MARK: - Functions
    func changeSliderHeight(height: CGFloat) {
        let heightRatio = (sliderHeight / maxHeight)
        let celsiusToAdd = Double(heightRatio) * TempConstant.tempDifferentCelsius
        let roundedCelsiusToAdd = celsiusToAdd.rounded(.toNearestOrAwayFromZero)
        temperature.kelvinValue = (TempConstant.minTempCelsius + roundedCelsiusToAdd).celsiusToKelvin()
    }
}

// MARK: - Preview
struct TempSliderView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        TempSliderView(
            temperature: .constant(sampleTemp),
            appTheme: .init(theme: .inactive),
            isTurnedOn: false
        )
            .padding()
            .previewLayout(.sizeThatFits)
        
        TempSliderView(
            temperature: .constant(sampleTemp2),
            appTheme: .init(theme: .inactive),
            isTurnedOn: false
        )
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
