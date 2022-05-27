//
//  ContentView.swift
//  ContactList
//
//  Created by Сергей Веретенников on 22/05/2022.
//

import SwiftUI

struct StarterView: View {
    
    @EnvironmentObject var contacts: Contacts
    
    var body: some View {
        NavigationView {
        ZStack {
                Color.mint
                    .ignoresSafeArea()
                VStack {
                    NavigationLink("Try demo") {
                        DemoView()
                    }
                    .modifier(ButtonMod(color: .yellow))
                    .padding()
                    NavigationLink("Try app") {
                        
                    }
                    .modifier(ButtonMod(color: .yellow))
                }
                .padding(.bottom, 80)
                .navigationTitle("Try my ''App''")
            }
        }
    }
}

struct StarterView_Previews: PreviewProvider {
    static var previews: some View {
        StarterView()
            .environmentObject(Contacts())
    }
}
