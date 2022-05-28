//
//  AddContactView.swift
//  ContactsProj
//
//  Created by Сергей Веретенников on 24/05/2022.
//

import SwiftUI
import CoreData

enum Field {
    case name
    case secondName
    case phone
}

struct AddContactView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @Binding var isPresented: Bool
    
    @State private var name = ""
    @State private var secondName = ""
    @State private var number = ""
    @State private var photo: Data? = nil
    @State private var isAlertPresented = false
    
    @FocusState private var focusedField: Field?
    
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Button(action: randomContact ) {
                    Text("Add random user from api?").bold()
                }
                ZStack {
                    Rectangle()
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 150)
                        .addShadow()
                    VStack {
                        TextFieldView(textInTF: $number, placeHolder: "Contact number", name: "Number")
                            .focused($focusedField, equals: .phone)
                            .submitLabel(.next)
                            .simultaneousGesture(TapGesture().onEnded {
                                focusedField = .phone
                            })
                        TextFieldView(textInTF: $name,placeHolder: "Contact name", name: "Name")
                            .focused($focusedField, equals: .name)
                            .submitLabel(.next)
                            .simultaneousGesture(TapGesture().onEnded {
                                focusedField = .name
                            })
                        TextFieldView(textInTF: $secondName, placeHolder: "Contact last name", name: "Last name")
                            .focused($focusedField, equals: .secondName)
                            .submitLabel(.done)
                            .simultaneousGesture(TapGesture().onEnded {
                                focusedField = .secondName
                            })
                    }
                }.padding(.bottom, 200)
                Buttons(
                    name: $name,
                    secondName: $secondName,
                    number: $number,
                    isPresented: $isPresented,
                    isAlertPresented: $isAlertPresented,
                    photo: $photo
                )
            }
        }
        .alert("Enter all fields", isPresented: $isAlertPresented, actions: {} )
        .onSubmit {
            switch focusedField {
            case .phone:
                focusedField = .name
            case .name:
                focusedField = .secondName
            case .secondName:
                newContactWith(name, secondName, number, photo)
            default: break
            }
        }
        .onTapGesture {
            focusedField = nil
        }
    }
    
    private func randomContact() {
        NetworkManager.shared.fetchRequestWith(url: "https://randomuser.me/api/") { result in
            switch result {
            case .success(let contact):
                    name = contact.0.results.first?.name.first ?? ""
                    secondName = contact.0.results.first?.name.last ?? ""
                    number = contact.0.results.first?.phone ?? ""
                    photo = contact.1
                    focusedField = .secondName
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func newContactWith(_ name: String, _ secondName: String, _ number: String, _ photo: Data?) {
        withAnimation {
            
            if name.isEmpty || secondName.isEmpty || number.isEmpty {
                isAlertPresented.toggle()
                return
            }
            
            let newContact = Contact(context: context)
            newContact.name = name
            newContact.secondName = secondName
            newContact.number = number
            newContact.picture = photo
            newContact.id = UUID()
            
            do {
                try context.save()
                isPresented.toggle()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(isPresented: .constant(true))
    }
}


struct Buttons: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @Binding var name: String
    @Binding var secondName: String
    @Binding var number: String
    @Binding var isPresented: Bool
    @Binding var isAlertPresented: Bool
    @Binding var photo: Data?
    
    var body: some View {
        HStack {
            Button {
                photo = nil
                isPresented.toggle()
            } label: {
                Text("Cancel")
                    .frame(width: 100, alignment: .leading)
                    .foregroundColor(.red)
            }
            .padding(.leading, 40)
            
            Spacer()
            
            Button {
                newContactWith(name, secondName, number, photo)
            } label: {
                Text("Add contact").bold()
                    .frame(width: 100, alignment: .trailing)
            }
            .padding(.trailing, 40)
        }
    }
    
    private func newContactWith(_ name: String, _ secondName: String, _ number: String, _ photo: Data?) {
        withAnimation {
            if name.isEmpty || secondName.isEmpty || number.isEmpty {
                isAlertPresented.toggle()
                return
            }
            
            let newContact = Contact(context: context)
            newContact.name = name
            newContact.secondName = secondName
            newContact.number = number
            newContact.picture = photo
            newContact.id = UUID()
            
            do {
                try context.save()
                isPresented.toggle()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

