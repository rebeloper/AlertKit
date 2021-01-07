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
    
    public func customAlert<AlertContent: View>(manager: CustomAlertManager, content: @escaping () -> AlertContent, buttons: [CustomAlertButton]) -> some View {
        self.modifier(CustomAlertViewModifier(customAlertManager: manager, alertContent: content, buttons: buttons))
    }
    
}
