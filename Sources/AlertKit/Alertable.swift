//
//  Alertable.swift
//  
//
//  Created by Alex Nagy on 25.12.2020.
//

import SwiftUI

@available(iOS 14.0, *)
public struct Alertable: ViewModifier {
    
    @StateObject public var alertManager = AlertManager()
    
    public func body(content: Content) -> some View {
        content.alertManager(alertManager)
    }
}
