//
//  AlertManager.swift
//  
//
//  Created by Alex Nagy on 25.12.2020.
//

import SwiftUI

public class AlertManager: ObservableObject {
    @Published public var alertItem: AlertItem?
    @Published public var actionSheetItem: ActionSheetItem?
    
    @Published public var isUniversalAlertPresented: Bool = false
    @Published public var universalAlertViewModel: UniversalAlertViewModel?
    @Published public var universalAlertContent: AnyView?
    @Published public var universalAlertActions: [UniversalAlertButton]?
    
    public init() { }
    
    public func show(dismiss: AlertItem.Dismiss) {
        alertItem = AlertItem(dismiss: dismiss, primarySecondary: Optional.none)
    }
    
    public func show(primarySecondary: AlertItem.PrimarySecondary) {
        alertItem = AlertItem(dismiss: Optional.none, primarySecondary: primarySecondary)
    }
    
    public func showActionSheet(_ sheet: ActionSheetItem.DefaultActionSheet) {
        actionSheetItem = ActionSheetItem(defaultActionSheet: sheet)
    }
    
    public func showUniversalAlert<Content: View>(viewModel: UniversalAlertViewModel = UniversalAlertViewModel(), @ViewBuilder content: @escaping () -> Content, actions: [UniversalAlertButton]) {
        isUniversalAlertPresented = true
        universalAlertViewModel = viewModel
        universalAlertContent = content() as? AnyView
        universalAlertActions = actions
    }
}
