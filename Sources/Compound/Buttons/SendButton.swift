// 
// Copyright 2024 New Vector Ltd
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial
// Please see LICENSE files in the repository root for full details.
//

import SwiftUI

/// The button component for sending messages and media.
public struct SendButton: View {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.colorScheme) private var colorScheme
    
    /// The action to perform when the user triggers the button.
    public let action: () -> Void
    
    private var iconColor: Color {
        guard isEnabled else { return .compound.iconQuaternary }
        return colorScheme == .light ? .compound.iconOnSolidPrimary : .compound.iconPrimary
    }
    
    private var gradient: Gradient { isEnabled ? enabledGradient : .init(colors: [.clear]) }
    
    /// This is a custom gradient used for this button, the colours don't come from our core tokens
    /// and aren't reactive to light/dark mode or high contrast, so it is hard coded in here.
    private var enabledGradient: Gradient {
        .init(stops: [Gradient.Stop(color: Color(red: 0.47, green: 0.87, blue: 0.6), location: 0.00),
                      Gradient.Stop(color: Color(red: 0.05, green: 0.74, blue: 0.55), location: 0.30),
                      Gradient.Stop(color: Color(red: 0.07, green: 0.52, blue: 0.52), location: 0.60),
                      Gradient.Stop(color: Color(red: 0.14, green: 0.27, blue: 0.42), location: 1.00)])
    }
    
    /// Creates a send button that performs the provided action.
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            CompoundIcon(\.sendSolid, size: .medium, relativeTo: .compound.headingLG)
                .foregroundStyle(iconColor)
                .scaledPadding(6, relativeTo: .compound.headingLG)
                .background { buttonShape }
                .compositingGroup()
        }
    }
    
    var buttonShape: some View {
        Circle()
        // Tchap: use Tchap main background action color.
//            .fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
            .fill(.compound.bgActionPrimaryRest)
    }
}

// MARK: - Previews

public struct SendButton_Previews: PreviewProvider, TestablePreview {
    public static var previews: some View {
        VStack(spacing: 0) {
            states
                .padding(20)
                .background(.compound.bgCanvasDefault)
            states
                .padding(20)
                .background(.compound.bgCanvasDefault)
                .environment(\.colorScheme, .dark)
        }
        .cornerRadius(20)
    }
    
    public static var states: some View {
        HStack(spacing: 30) {
            SendButton { }
                .disabled(true)
            SendButton { }
        }
    }
}
