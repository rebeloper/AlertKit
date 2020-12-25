//
//  ActionSheetItem.swift
//  
//
//  Created by Alex Nagy on 25.12.2020.
//

import SwiftUI

public struct ActionSheetItem: Identifiable {
    public let id = UUID()
    public var defaultActionSheet: DefaultActionSheet
    
    public enum DefaultActionSheet {
        case custom(title: String, message: String, buttons: [Alert.Button] = [.cancel(Text("OK"))])
        case none
        
        public var title: String {
            switch self {
            case let .custom(title, _, _):
                return title
            case .none:
                return ""
            }
        }
        
        public var message: String {
            switch self {
            case let .custom(_, message, _):
                return message
            case .none:
                return ""
            }
        }
        
        public var buttons: [Alert.Button] {
            switch self {
            case let .custom(_, _, buttons):
                return buttons
            case .none:
                return []
            }
        }
        
    }
    
}

