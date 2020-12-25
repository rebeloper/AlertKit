//
//  AlertManager.swift
//  
//
//  Created by Alex Nagy on 25.12.2020.
//

import SwiftUI

public class AlertManager: ObservableObject {
    @Published public var alertItem: AlertItem?
    public init() { }
    
    public func show(dismiss: AlertItem.Dismiss) {
        print("Showing dismiss with message: \(dismiss.message)")
        alertItem = AlertItem(dismiss: dismiss, primarySecondary: Optional.none)
    }
    
    public func show(primarySecondary: AlertItem.PrimarySecondary) {
        alertItem = AlertItem(dismiss: Optional.none, primarySecondary: primarySecondary)
    }
}
