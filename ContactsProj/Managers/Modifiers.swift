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

struct SwipeActions: ViewModifier {
    
    @Binding var indexx: Int
    let callContact: (Int) -> Void
    let index: Int
    @Binding var isDeleteAlertPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button {
                    callContact(Int(index))
                } label: {
                    Image(systemName: "phone")
                }
                .tint(.green)
            }
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                Button(role: .destructive) {
                    self.indexx = Int(index)
                    isDeleteAlertPresented.toggle()
                } label: {
                    Image(systemName: "trash.circle")
                }
            }
    }
}

extension View {
    
    func callDeleteSwipes(indexx: Binding<Int>, callContact: @escaping (Int) -> Void, index: Int, isDeleteAlertPresented: Binding<Bool> ) -> some View {
        modifier(SwipeActions(indexx: indexx, callContact: callContact, index: index, isDeleteAlertPresented: isDeleteAlertPresented))
    }
    
    func addShadow() -> some View {
        modifier(ShadowMod())
    }
    
}
