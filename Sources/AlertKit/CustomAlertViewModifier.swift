//
//  CustomAlertViewModifier.swift
//  
//
//  Created by Alex Nagy on 07.01.2021.
//

import SwiftUI

public struct CustomAlertViewModifier<AlertContent: View>: ViewModifier {
    
    @ObservedObject public var customAlertManager: CustomAlertManager
    public var alertContent: () -> AlertContent
    public var buttons: [CustomAlertButton]
    
    public var requireHorizontalPositioning: Bool {
        let maxButtonPositionedHorizontally = 2
        return buttons.count > maxButtonPositionedHorizontally
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content.disabled(customAlertManager.isPresented)
            if customAlertManager.isPresented {
                GeometryReader { geometry in
                    Color.black.opacity(0.2).ignoresSafeArea()
                    HStack {
                        Spacer()
                        VStack {
                            let expectedWidth = geometry.size.width * 0.7
                            
                            Spacer()
                            VStack(spacing: 0) {
                                alertContent().padding()
                                buttonsPad(expectedWidth)
                            }
                            .frame(
                                minWidth: expectedWidth,
                                maxWidth: expectedWidth
                            )
                            .background(Color(.systemBackground).opacity(0.95))
                            .cornerRadius(13)
                            Spacer()
                        }
                        Spacer()
                    }
                    
                }
            }
            
        }
    }
    
    public func buttonsPad(_ expectedWidth: CGFloat) -> some View {
        VStack(spacing: 0) {
            if buttons.count < 1 {
                fatalError("Please provide at least one button for your custom alert.")
            }
            if requireHorizontalPositioning {
                verticalButtonPad()
            } else {
                Divider().padding([.leading, .trailing], -12)
                horizontalButtonsPadFor(expectedWidth)
            }
        }
    }
    
    public func verticalButtonPad() -> some View {
        VStack(spacing: 0) {
            ForEach(0..<buttons.count) {
                Divider().padding([.leading, .trailing], -12)
                let current = buttons[$0]
                
                Button(action: {
                    if !current.isCancel {
                        current.action()
                    }
                    
                    withAnimation {
                        self.customAlertManager.isPresented.toggle()
                    }
                }, label: {
                    current.content
                })
                .disabled(current.isDisabled)
                .padding(8)
                .frame(minHeight: 44)
            }
        }
    }
    
    public func horizontalButtonsPadFor(_ expectedWidth: CGFloat) -> some View {
        
        HStack(spacing: 0) {
            let sidesOffset: CGFloat = 12 * 2
            let maxHorizontalWidth = requireHorizontalPositioning ?
                expectedWidth - sidesOffset :
                expectedWidth / 2 - sidesOffset
            
            Spacer()
            
            if !requireHorizontalPositioning {
                ForEach(0..<buttons.count) {
                    if $0 != 0 {
                        Divider().frame(height: 44)
                    }
                    let current = buttons[$0]
                    
                    Button(action: {
                        if !current.isCancel {
                            current.action()
                        }
                        
                        withAnimation {
                            self.customAlertManager.isPresented.toggle()
                        }
                    }, label: {
                        current.content
                    })
                    .padding(8)
                    .frame(maxWidth: maxHorizontalWidth, minHeight: 44)
                }
            }
            
            Spacer()
        }
    }
    
}

#if os(watchOS)
extension UIColor {
    public static var systemBackground: UIColor {
        return UIColor(.black)
    }
}
#endif
