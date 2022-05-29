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
                    Image(systemName: "person.3")
                    Text("Contacts")
                }
            Profile()
                .tabItem {
                    Image(systemName: "person.crop.circle")
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
