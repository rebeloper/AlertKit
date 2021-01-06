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
    
    public func universalAlert<Content: View>(isShowing: Binding<Bool>, viewModel: UniversalAlertViewModel, @ViewBuilder content: @escaping () -> Content, actions: [UniversalAlertButton]) -> some View {
        UniversalAlert(isShowing: isShowing, displayContent: content(), buttons: actions, presentationView: self, viewModel: viewModel)
    }
}
