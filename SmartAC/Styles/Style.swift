//
//  Style.swift
//  SmartAC
//
//  Created by Wind Versi on 21/6/22.
//

import SwiftUI

// MARK: - Color
enum Colors: String {
    case hotBackground = "Orange"
    case hotLightBackground = "Light Orange"
    case coldBackground = "Blue"
    case coldLightBackground = "Light Blue"
    case onPrimary = "Black"
    case primary = "White"
    var color: Color {
        Color(self.rawValue)
    }
}

// MARK: - Icon
enum Icons: String {
    case cool = "Cool Icon"
    case fan = "Fan Icon"
    case power = "Power Icon"
    case smoke = "Smoke Illus"
    var image: Image {
        Image(self.rawValue)
    }
}

// MARK: - Text
enum Fonts: String {
    case openSansSemiBold = "OpenSans-SemiBold"
    var value: String {
        self.rawValue
    }
}

struct CustomText: ViewModifier {
    var foregroundColor: Color
    var font: String
    var size: Int
    var maxWidth: CGFloat?
    var alignment: Alignment
    var lineLimit: Int?
    var lineSpacing: CGFloat
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundColor)
            .font(
                Font.custom(
                    font,
                    size: CGFloat(size)
                )
            )
            .frame(
                maxWidth: maxWidth,
                alignment: alignment
            )
            .lineLimit(lineLimit)
            .lineSpacing(lineSpacing)
    }
}

extension View {
    
    /// Sets the style of the Text
    ///
    /// - Parameters:
    ///   - foregroundColor: The color of the text
    ///   - font: The custom font e.g. "Arial-Bold"
    ///   - size: The font size
    ///   - maxWidth: The text will fill all the available width of its parent
    ///   - alignment: The alignment of the text relative to its width
    ///   - linelimit: Limit the text per line. Overflowing text in single line will be truncated with ...
    ///   - lineSpacing: The space between lines of text
    ///
    /// - Returns: A Text View with new Style
    func textStyle(
        foregroundColor: Color = Colors.onPrimary.color,
        font: Fonts = .openSansSemiBold,
        size: Int = 12,
        maxWidth: CGFloat? = nil,
        alignment: Alignment = .leading,
        lineLimit: Int? = nil,
        lineSpacing: CGFloat = 0
    ) -> some View {
        self.modifier(
            CustomText(
                foregroundColor: foregroundColor,
                font: font.value,
                size: size,
                maxWidth: maxWidth,
                alignment: alignment,
                lineLimit: lineLimit,
                lineSpacing: lineSpacing
            )
        )
    }
    
}

// MARK: - Frame
struct FrameModifier: ViewModifier {
    var maxWidth: CGFloat?
    var maxHeight: CGFloat?
    var alignment: Alignment
    
    func body(content: Content) -> some View {
        content.frame(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            alignment: alignment
        )
    }
}

extension View {
    func fillMaxHeight(
        alignment: Alignment = .center
    ) -> some View {
        modifier(
            FrameModifier(
                maxWidth: nil,
                maxHeight: .infinity,
                alignment: alignment
            )
        )
    }
    
    func fillMaxWidth(
        alignment: Alignment = .center
    ) -> some View {
        modifier(
            FrameModifier(
                maxWidth: .infinity,
                maxHeight: nil,
                alignment: alignment
            )
        )
    }
    
    func fillMaxSize(
        alignment: Alignment = .center
    ) -> some View {
        modifier(
            FrameModifier(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: alignment
            )
        )
    }
}
