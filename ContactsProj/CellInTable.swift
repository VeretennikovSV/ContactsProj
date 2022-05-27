//
//  CellInTable.swift
//  ContactList
//
//  Created by Сергей Веретенников on 22/05/2022.
//

import SwiftUI

struct CellInTable: View {
    
    let name: String
    let secondName: String
    
    var body: some View {
        HStack {
            Text(name)
                .bold()
                .font(.system(size: 20))
                .frame(width: 120, alignment: .leading)
            Text(secondName)
                .frame(alignment: .trailing)
                .font(.system(size: 20))
                .padding(.leading, 16)
        }
    }
}

struct CellInTable_Previews: PreviewProvider {
    static var previews: some View {
        CellInTable(name: "123", secondName: "123")
    }
}
