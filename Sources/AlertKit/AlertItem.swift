//
//  AlertItem.swift
//  
//
//  Created by Alex Nagy on 25.12.2020.
//

import SwiftUI

public struct AlertItem: Identifiable {
    public let id = UUID()
    public var dismiss: Dismiss? = nil
    public var primarySecondary: PrimarySecondary? = nil
    
    public enum Dismiss {
        case error(title: String = "Error", message: String = "Something went wrong", dismissButton: Alert.Button? = .cancel(Text("OK")))
        case warning(title: String = "Warning", message: String = "Something went wrong", dismissButton: Alert.Button? = .cancel(Text("OK")))
        case success(title: String = "Success", message: String = "The operation was successfull", dismissButton: Alert.Button? = .cancel(Text("OK")))
        case info(title: String = "Info", message: String, dismissButton: Alert.Button? = .cancel(Text("OK")))
        case custom(title: String, message: String, dismissButton: Alert.Button? = .cancel(Text("OK")))
        case none
        
        public var title: String {
            switch self {
            case let .error(title, _, _):
                return title
            case let .warning(title, _, _):
                return title
            case let .success(title, _, _):
                return title
            case let .info(title, _, _):
                return title
            case let .custom(title, _, _):
                return title
            case .none:
                return ""
            }
        }
        
        public var message: String {
            switch self {
            case let .error(_, message, _):
                return message
            case let .warning(_, message, _):
                return message
            case let .success(_, message, _):
                return message
            case let .info(_, message, _):
                return message
            case let .custom(_, message, _):
                return message
            case .none:
                return ""
            }
        }
        
        public var dismissButton: Alert.Button? {
            switch self {
            case let .error(_, _, dismissButton):
                return dismissButton
            case let .warning(_, _, dismissButton):
                return dismissButton
            case let .success(_, _, dismissButton):
                return dismissButton
            case let .info(_, _, dismissButton):
                return dismissButton
            case let .custom(_, _, dismissButton):
                return dismissButton
            case .none:
                return nil
            }
        }
        
    }
    
    public enum PrimarySecondary {
        case error(title: String = "Error", message: String = "Something went wrong", primaryButton: Alert.Button = .default(Text("OK")), secondaryButton: Alert.Button = .cancel())
        case warning(title: String = "Warning", message: String = "Something went wrong", primaryButton: Alert.Button = .default(Text("OK")), secondaryButton: Alert.Button = .cancel())
        case success(title: String = "Success", message: String = "The operation was successfull", primaryButton: Alert.Button = .default(Text("OK")), secondaryButton: Alert.Button = .cancel())
        case info(title: String = "Info", message: String, primaryButton: Alert.Button = .default(Text("OK")), secondaryButton: Alert.Button = .cancel())
        case custom(title: String, message: String, primaryButton: Alert.Button = .default(Text("OK")), secondaryButton: Alert.Button = .cancel())
        case none
        
        public var title: String {
            switch self {
            case let .error(title, _, _, _):
                return title
            case let .warning(title, _, _, _):
                return title
            case let .success(title, _, _, _):
                return title
            case let .info(title, _, _, _):
                return title
            case let .custom(title, _, _, _):
                return title
            case .none:
                return ""
            }
        }
        
        public var message: String {
            switch self {
            case let .error(_, message, _, _):
                return message
            case let .warning(_, message, _, _):
                return message
            case let .success(_, message, _, _):
                return message
            case let .info(_, message, _, _):
                return message
            case let .custom(_, message, _, _):
                return message
            case .none:
                return ""
            }
        }
        
        public var primaryButton: Alert.Button? {
            switch self {
            case let .error(_, _, primaryButton, _):
                return primaryButton
            case let .warning(_, _, primaryButton, _):
                return primaryButton
            case let .success(_, _, primaryButton, _):
                return primaryButton
            case let .info(_, _, primaryButton, _):
                return primaryButton
            case let .custom(_, _, primaryButton, _):
                return primaryButton
            case .none:
                return nil
            }
        }
        
        public var secondaryButton: Alert.Button? {
            switch self {
            case let .error(_, _, _, secondaryButton):
                return secondaryButton
            case let .warning(_, _, _, secondaryButton):
                return secondaryButton
            case let .success(_, _, _, secondaryButton):
                return secondaryButton
            case let .info(_, _, _, secondaryButton):
                return secondaryButton
            case let .custom(_, _, _, secondaryButton):
                return secondaryButton
            case .none:
                return nil
            }
        }
        
    }
}
