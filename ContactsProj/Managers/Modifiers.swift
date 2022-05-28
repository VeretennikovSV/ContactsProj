//
//  Modifiers.swift
//  ContactList
//
//  Created by Сергей Веретенников on 22/05/2022.
//

import Foundation
import SwiftUI

struct ButtonMod: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .frame(width: 100)
            .overlay(RoundedRectangle(cornerRadius: 2).stroke(.black, lineWidth: 1).shadow(color: .black, radius: 3))
            .background(color)
    }
}

struct ShadowMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.3), radius: 3, x: -4, y: -4)
            .shadow(color: .gray.opacity(0.4), radius: 7, x: 7, y: 7)
    }
}


extension View {
    
    func addShadow() -> some View {
        modifier(ShadowMod())
    }
    
}
