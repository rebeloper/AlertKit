//
//  View+.swift
//  
//
//  Created by Alex Nagy on 25.12.2020.
//

import SwiftUI

extension View {
    
    public func uses(_ alertManager: AlertManager) -> some View {
        self.modifier(AlertViewModifier(alertManager: alertManager))
    }
    
}
