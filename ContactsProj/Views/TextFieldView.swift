//
//  TextFieldView.swift
//  ContactsProj
//
//  Created by Сергей Веретенников on 24/05/2022.
//

import SwiftUI

struct TextFieldView: View {
    
    @Binding var textInTF: String
    let placeHolder: String
    let name: String
    
    var body: some View {
        HStack {
            Text(name)
                .frame(width: 67, alignment: .leading)
                .font(.system(size: 14))
            Text("|")
            TextField(placeHolder, text: $textInTF)
                .frame(width: 200)
                .keyboardType(.default)
                .textFieldStyle(.roundedBorder)
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(textInTF: .constant(""), placeHolder: "aaaa", name: "Last name")
    }
}
