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
