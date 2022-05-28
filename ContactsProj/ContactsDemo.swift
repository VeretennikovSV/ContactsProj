//
//  ContactsDemo.swift
//  ContactList
//
//  Created by Сергей Веретенников on 22/05/2022.
//

import SwiftUI
import CoreData

struct ContactsDemo: View {
    
    @Environment(\.managedObjectContext) private var context
    @State private var isSheetPresented = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Contact.name, ascending: true)],
        animation: .default
    )
    
    private var contacts: FetchedResults<Contact>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contacts, id: \.self) { cont in
                    Section(cont.secondName) {
                        NavigationLink {
                            InfoAboutContact(
                                name: cont.name,
                                secondName: cont.secondName,
                                number: cont.number,
                                photo: cont.picture,
                                barTitle: "\(cont.name) \(cont.secondName)",
                                contact: cont
                            )
                        } label: {
                            CellInTable(name: cont.name, secondName: cont.number)
                        }
                    }
                    .font(.system(size: 13))
                }
                .onDelete { indexSet in
                    deleteContact(offset: indexSet)
                }
            }
            .navigationTitle("My contacts")
            .toolbar {
                HStack {
                    Button {
                        addContact()
                    } label: {
                        Image(systemName: "plus")
                    }
                    Button {
                        NetworkManager.shared.fetchRequestWith(url: "https://randomuser.me/api/") { result in
                            switch result {
                            case .success(let contact):
                                print(contact.results)
                            case .failure(let error):
                                print("Жопа")
                            }
                        }
                    } label: {
                        Image(systemName: "checkmark")
                    }

//                    EditButton()
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                AddContactView(isPresented: $isSheetPresented)
            }
        }
    }
    
    private func addContact() {
        isSheetPresented.toggle()
    }
    
    private func deleteContact(offset: IndexSet) {
        withAnimation {
            for index in offset {
                context.delete(contacts[index])
            }
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct ContactsDemo_Previews: PreviewProvider {
    static var previews: some View {
        ContactsDemo()
            .environmentObject(Contacts())
    }
}
