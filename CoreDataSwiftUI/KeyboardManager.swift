//
//  KeyboardManager.swift
//  CoreDataSwiftUI
//
//  Created by i mac on 12/01/2023.
//

import SwiftUI

public struct KeyboardManager<Content>: View where Content: View {
    
    /// - Parameter content: some View
    public init (@ViewBuilder content: () -> Content) {
        view = content()
    }
    
    public var body: some View {
        VStack {
            view
            Spacer()
                .frame(height: keyboardHeight)
                .animation(.default)
                .foregroundColor(.clear)
        }.onReceive(showPublisher.merge(with: hidePublisher)) { (height) in
            self.keyboardHeight = height
        }
    }
    
    let view: Content
    
    @State private var keyboardHeight: CGFloat = 0
    
    private let showPublisher = NotificationCenter.Publisher.init(
        center: .default,
        name: UIResponder.keyboardWillShowNotification
    ).map { (notification) -> CGFloat in
        if let rect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            return rect.size.height
        } else {
            return 0
        }
    }
    
    private let hidePublisher = NotificationCenter.Publisher.init(
        center: .default,
        name: UIResponder.keyboardWillHideNotification
    ).map { _ -> CGFloat in
        return 0
    }
}
