//
//  UniversalAlertItem.swift
//  
//
//  Created by Alex Nagy on 06.01.2021.
//

import SwiftUI

public struct UniversalAlertItem<Content: View>: Identifiable {
    public let id = UUID()
    public var defaultUniversalAlert: DefaultUniversalAlert
    
    public enum DefaultUniversalAlert {
        case custom(content: Content, buttons: [UniversalAlertButton] = [UniversalAlertButton.cancel(content: {
            Text("Cancel").bold()
        })])
        case none
        
        public var content: Content {
            switch self {
            case let .custom(content, _):
                return content
            case .none:
                return EmptyView() as! Content
            }
        }
        
        public var buttons: [UniversalAlertButton] {
            switch self {
            case let .custom(_, buttons):
                return buttons
            case .none:
                return []
            }
        }
        
    }
}
