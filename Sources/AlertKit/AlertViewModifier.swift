//
//  AlertViewModifier.swift
//  
//
//  Created by Alex Nagy on 25.12.2020.
//

import SwiftUI

public struct AlertViewModifier: ViewModifier {
    
    @ObservedObject public var alertManager: AlertManager
    
    public func body(content: Content) -> some View {
        content
            .alert(item: $alertManager.alertItem, content: { (item) -> Alert in
                if item.dismiss != nil {
                    if let type = item.dismiss {
                        return Alert(title: Text(type.title), message: Text(type.message), dismissButton: type.dismissButton)
                    } else {
                        return Alert(title: Text("Error"), message: Text("Something went terribly wrong"), dismissButton: .cancel(Text("OK")))
                    }
                    
                } else if item.primarySecondary != nil {
                    if let type = item.primarySecondary {
                        return Alert(title: Text(type.title), message: Text(type.message), primaryButton: type.primaryButton ?? .default(Text("OK")), secondaryButton: type.secondaryButton ?? .cancel())
                    } else {
                        return Alert(title: Text("Error"), message: Text("Something went terribly wrong"), dismissButton: .cancel(Text("OK")))
                    }
                    
                } else {
                    return Alert(title: Text("Error"), message: Text("Something went terribly wrong"), dismissButton: .cancel(Text("OK")))
                }
            })
            .actionSheet(item: $alertManager.alertItem) { (item) -> ActionSheet in
                return ActionSheet(title: Text("Title"), message: Text("message"), buttons: [.cancel()])
            }
    }
}
