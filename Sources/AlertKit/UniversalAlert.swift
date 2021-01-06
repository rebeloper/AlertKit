//
//  UniversalAlert.swift
//  
//
//  Created by Alex Nagy on 06.01.2021.
//

import SwiftUI

public struct UniversalAlert<Presenter, Content>: View where Presenter: View, Content: View {
    
    @Binding public var isShowing: Bool
    
    public let displayContent: Content
    public let buttons: [UniversalAlertButton]
    public let presentationView: Presenter
    public let viewModel: UniversalAlertViewModel
    
    public var requireHorizontalPositioning: Bool {
        let maxButtonPositionedHorizontally = 2
        return buttons.count > maxButtonPositionedHorizontally
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundColor()
                
                VStack {
                    Spacer()
                    
                    ZStack {
                        presentationView.disabled(isShowing)
                        let expectedWidth = geometry.size.width * 0.7
                        
                        VStack {
                            displayContent.padding(viewModel.contentPadding)
                            buttonsPad(expectedWidth)
                        }
                        .background(viewModel.contentBackgroundColor)
                        .cornerRadius(viewModel.contentCornerRadius)
                        .shadow(radius: 1)
                        .opacity(self.isShowing ? 1 : 0)
                        .frame(
                            minWidth: expectedWidth,
                            maxWidth: expectedWidth
                        )
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    public func backgroundColor() -> some View {
        viewModel.backgroundColor
            .edgesIgnoringSafeArea(.all)
            .opacity(self.isShowing ? 1 : 0)
    }
    
    public func buttonsPad(_ expectedWidth: CGFloat) -> some View {
        VStack(spacing: 0) {
            if requireHorizontalPositioning {
                verticalButtonPad()
            } else {
                Divider().padding([.leading, .trailing], -viewModel.contentPadding)
                horizontalButtonsPadFor(expectedWidth)
            }
        }
    }
    
    public func verticalButtonPad() -> some View {
        VStack {
            ForEach(0..<buttons.count) {
                Divider().padding([.leading, .trailing], -viewModel.contentPadding)
                let current = buttons[$0]
                
                Button(action: {
                    if !current.isCancel {
                        current.action()
                    }
                    
                    withAnimation {
                        self.isShowing.toggle()
                    }
                }, label: {
                    current.content.frame(height: 35)
                })
            }
        }
    }
    
    public func horizontalButtonsPadFor(_ expectedWidth: CGFloat) -> some View {
        HStack {
            let sidesOffset = viewModel.contentPadding * 2
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
                            self.isShowing.toggle()
                        }
                    }, label: {
                        current.content
                    })
                    .frame(maxWidth: maxHorizontalWidth, minHeight: 44)
                }
            }
            Spacer()
        }
    }
}
