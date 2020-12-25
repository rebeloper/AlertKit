//
//  View+.swift
//  
//
//  Created by Alex Nagy on 25.12.2020.
//

import SwiftUI

extension View {
    
    public func alertable() -> some View {
        modifier(Alertable())
    }
    
    public func alertManager(_ alertManager: AlertManager) -> some View {
        self.modifier(AlertViewModifier(alertManager: alertManager))
    }
}
