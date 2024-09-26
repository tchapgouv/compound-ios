//
// Copyright 2023, 2024 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only
// Please see LICENSE in the repository root for full details.
//

import CompoundDesignTokens
import SwiftUI

public extension Color {
    /// The colours used by Element as defined in Compound Design Tokens.
    static let compound = CompoundColors()
}

public extension ShapeStyle where Self == Color {
    /// The colours used by Element as defined in Compound Design Tokens.
    static var compound: CompoundColors { Self.compound }
}

/// The colours used by Element as defined in Compound Design Tokens.
/// This struct contains only the colour tokens in a more usable form.
@dynamicMemberLookup
public class CompoundColors {
    /// The base colour tokens that form the palette of available colours.
    ///
    /// Normally these shouldn't be necessary, however in practice we may need
    /// access for temporary tokens while waiting for official ones to be formalised.
    private static let coreTokens = CompoundCoreColorTokens.self
    /// The main semantic tokens generated from the Style Dictionary.
    private let tokens: CompoundColorTokens
    /// Runtime overrides for the `tokens` property.
    private var overrides = [KeyPath<CompoundColorTokens, Color>: Color]()
    
    public subscript(dynamicMember keyPath: KeyPath<CompoundColorTokens, Color>) -> Color {
        return overrides[keyPath] ?? tokens[keyPath: keyPath]
    }
    
    /// Customise the colour at the specified key path with the supplied colour.
    /// Supplying `nil` as the colour will remove any existing customisation.
    public func override(_ keyPath: KeyPath<CompoundColorTokens, Color>, with color: Color?) {
        overrides[keyPath] = color
    }
    
    init() {
        let tokens = CompoundColorTokens()
        self.tokens = tokens
        
        decorativeColors = [
           .init(background: tokens.bgDecorative1, text: tokens.textDecorative1),
           .init(background: tokens.bgDecorative2, text: tokens.textDecorative2),
           .init(background: tokens.bgDecorative3, text: tokens.textDecorative3),
           .init(background: tokens.bgDecorative4, text: tokens.textDecorative4),
           .init(background: tokens.bgDecorative5, text: tokens.textDecorative5),
           .init(background: tokens.bgDecorative6, text: tokens.textDecorative6),
       ]
    }
    
    // MARK: - Elevation Tokens
    // This is a workaround until they are generated correctly
    
    public let bgSubtleSecondaryLevel0 = Color(UIColor { $0.isLight ? UIColor(coreTokens.gray300) : UIColor(coreTokens.themeBg) })
    public let bgCanvasDefaultLevel1 = Color(UIColor { $0.isLight ? UIColor(coreTokens.themeBg) : UIColor(coreTokens.gray300) })
    
    // MARK: - Decorative Colors
    // Used to determine the background and text colors of avatars, usernames etc.
    
    let decorativeColors: [DecorativeColor]
    
    public func decorativeColor(for contentID: String) -> DecorativeColor {
        decorativeColors[contentID.hashCode]
    }
    
    // MARK: - Awaiting Semantic Tokens
    
    /// This token is a placeholder and hasn't been finalised.
    @available(iOS, deprecated: 17.0, message: "This token should be generated by now.")
    public let _borderTextFieldFocused = coreTokens.gray500
    /// This token is a placeholder and hasn't been finalised.
    @available(iOS, deprecated: 17.0, message: "This token should be generated by now.")
    public let _bgBubbleIncoming = Color(UIColor { $0.isLight ? UIColor(coreTokens.gray300) : UIColor(coreTokens.gray400) })
    /// This token is a placeholder and hasn't been finalised.
    @available(iOS, deprecated: 17.0, message: "This token should be generated by now.")
    public let _bgBubbleOutgoing = Color(UIColor { $0.isLight ? UIColor(coreTokens.gray400) : UIColor(coreTokens.gray500) })
    /// This token is a placeholder and hasn't been finalised.
    @available(iOS, deprecated: 17.0, message: "This token should be generated by now.")
    public let _bgBubbleHighlighted = coreTokens.green300
    /// This token is a placeholder and hasn't been finalised.
    @available(iOS, deprecated: 17.0, message: "This token should be generated by now.")
    public let _bgCodeBlock = coreTokens.gray100
    /// This token is a placeholder and hasn't been finalised.
    @available(iOS, deprecated: 17.0, message: "This token should be generated by now.")
    public let _borderInteractiveSecondaryAlpha = coreTokens.alphaGray600
    /// This token is a placeholder and hasn't been finalised.
    @available(iOS, deprecated: 17.0, message: "This token should be generated by now.")
    public let _bgSubtleSecondaryAlpha = coreTokens.alphaGray300
    /// This token is a placeholder and hasn't been finalised.
    @available(iOS, deprecated: 17.0, message: "This token should be generated by now.")
    public let _bgCriticalSubtleAlpha = coreTokens.alphaRed300
    /// This token is a placeholder and hasn't been finalised.
    @available(iOS, deprecated: 17.0, message: "This token should be generated by now.")
    public let _bgEmptyItemAlpha = coreTokens.alphaGray500
    /// This token is a placeholder and hasn't been finalised.
    @available(iOS, deprecated: 17.0, message: "This token should be generated by now.")
    public let _bgAccentSelected = coreTokens.green300
    /// This token is a placeholder and hasn't been finalised.
    @available(iOS, deprecated: 17.0, message: "This token should be generated by now.")
    public let _bgPill = Color(UIColor { $0.isLight ? UIColor(coreTokens.alphaGray400) : UIColor(coreTokens.alphaGray500) })
    /// This token is a placeholder and hasn't been finalised.
    @available(iOS, deprecated: 17.0, message: "This token should be generated by now.")
    public let _bgOwnPill = Color(UIColor { $0.isLight ? UIColor(coreTokens.alphaGreen400) : UIColor(coreTokens.alphaGreen500) })
    /// This token is a placeholder and hasn't been finalised.
    @available(iOS, deprecated: 17.0, message: "This token should be generated by now.")
    public let _textOwnPill = coreTokens.green1100
    /// This token is a placeholder and hasn't been finalised.
    @available(iOS, deprecated: 17.0, message: "This token should be generated by now.")
    public let _bgBadgeSuccess = coreTokens.alphaGreen300
    /// This token is a placeholder and hasn't been finalised.
    @available(iOS, deprecated: 17.0, message: "This token should be generated by now.")
    public let _badgeTextSubtle = coreTokens.gray1100
    /// This token is a placeholder and hasn't been finalised.
    @available(iOS, deprecated: 17.0, message: "This token should be generated by now.")
    public let _badgeTextSuccess = coreTokens.green1100
    
    // MARK: - Gradients
    
    public let gradientSuperButton = Gradient(colors: [coreTokens.blue900, coreTokens.green1100])
}

private extension UITraitCollection {
    /// Whether or not the trait collection contains a `userInterfaceStyle` of `.light`.
    var isLight: Bool { userInterfaceStyle == .light }
}

public struct DecorativeColor: Equatable {
    public let background: Color
    public let text: Color
}

private extension String {
    /// Calculates a numeric hash same as Element Web
    /// See original function here https://github.com/matrix-org/matrix-react-sdk/blob/321dd49db4fbe360fc2ff109ac117305c955b061/src/utils/FormattingUtils.js#L47
    var hashCode: Int {
        let characterCodeSum = self.reduce(0) { sum, character in
            sum + Int(character.unicodeScalars.first?.value ?? 0)
        }
        return (characterCodeSum % Color.compound.decorativeColors.count)
    }
}
