//
//  CustomAlertManager.swift
//  
//
//  Created by Alex Nagy on 07.01.2021.
//

import SwiftUI

public class CustomAlertManager: ObservableObject {
    @Published public var isPresented: Bool
    
    public init(isPresented: Bool = false) {
        self.isPresented = isPresented
    }
    
    public func show() {
        isPresented = true
    }
    
    public func dismiss() {
        isPresented = false
    }
}
