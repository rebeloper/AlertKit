//
//  UniversalAlertButton.swift
//  
//
//  Created by Alex Nagy on 06.01.2021.
//

import SwiftUI

public struct UniversalAlertButton {
    
    public enum Variant {
        case cancel
        case regular
    }
    
    public let content: AnyView
    public let action: () -> Void
    public let type: Variant
    
    public var isCancel: Bool {
        type == .cancel
    }
    
    public static func cancel<Content: View>(@ViewBuilder content: @escaping () -> Content) -> UniversalAlertButton {
        UniversalAlertButton(content: content, action: { /* close */ }, type: .cancel)
    }
    
    public static func regular<Content: View>(@ViewBuilder content: @escaping () -> Content,
        action: @escaping () -> Void) -> UniversalAlertButton {
        UniversalAlertButton(content: content, action: action, type: .regular)
    }
    
    public init<Content: View>(@ViewBuilder content: @escaping () -> Content, action: @escaping () -> Void, type: Variant ) {
        self.content = AnyView(content())
        self.type = type
        self.action = action
    }
}
