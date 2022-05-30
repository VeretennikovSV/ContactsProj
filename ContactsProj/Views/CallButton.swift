//
//  CallButton.swift
//  ContactsProj
//
//  Created by Сергей Веретенников on 30/05/2022.
//

import SwiftUI

struct CallButton: View {
    
    let number: String
    
    var body: some View {
        Button {
            let callPhone = "tel://"
            let formatedCall = callPhone + number
            guard let url = URL(string: formatedCall) else { return }
            UIApplication.shared.open(url)
        } label: {
            Image(systemName: "phone")
        }
    }
}

struct CallButton_Previews: PreviewProvider {
    static var previews: some View {
        CallButton(number: "89117810495")
    }
}
