//
//  DemoView.swift
//  ContactList
//
//  Created by Сергей Веретенников on 22/05/2022.
//

import SwiftUI

struct DemoView: View {
    
    var body: some View {
        TabView {
            ContactsDemo()
                .tabItem {
                    Image(systemName: "checkmark")
                    Text("Contacts")
                }
            Profile()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

//struct DemoView_Previews: PreviewProvider {
//    static var previews: some View {
//        DemoView()
//    }
//}
