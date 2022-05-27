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
    @State private var phone = ""
    @State private var isAlertPresented = false
    @FocusState private var focused: Bool
    @FocusState private var focusedField: Field?
    
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                VStack {
                    TextFieldView(textInTF: $phone, placeHolder: "Contact number", name: "Number")
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
                .frame(width: 300, height: 150)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.gray, lineWidth: 0.4)
                        .shadow(color: .black, radius: 1)
                )
                .padding(.bottom, 200)
                
                Buttons(
                    name: $name,
                    secondName: $secondName,
                    number: $phone,
                    isPresented: $isPresented,
                    isAlertPresented: $isAlertPresented
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
                newContactWith(name, secondName, phone)
            default: break
            }
        }
        .ignoresSafeArea(.keyboard) // Cмещение нормальное ставить
        .focused($focused) //Фокус клавы снимать
        .onTapGesture {
            focused = false
        }
    }
    
    private func newContactWith(_ name: String, _ secondName: String, _ number: String) {
        withAnimation {
            
            if name.isEmpty || secondName.isEmpty || number.isEmpty {
                isAlertPresented.toggle()
                return
            }
            
            let newContact = Contact(context: context)
            newContact.name = name
            newContact.secondName = secondName
            newContact.number = number
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
    
    var body: some View {
        HStack {
            Button {
                isPresented.toggle()
            } label: {
                Text("Cancel")
                    .frame(width: 100)
                    .foregroundColor(.red)
            }
            .padding(.leading, 40)
            
            Spacer()
            
            Button {
                newContactWith(name, secondName, number)
            } label: {
                Text("Add contact").bold()
                    .frame(width: 100)
            }
            .padding(.trailing, 40)
        }
    }
    
    private func newContactWith(_ name: String, _ secondName: String, _ number: String) {
        withAnimation {
            
            if name.isEmpty || secondName.isEmpty || number.isEmpty {
                isAlertPresented.toggle()
                return
            }
            
            let newContact = Contact(context: context)
            newContact.name = name
            newContact.secondName = secondName
            newContact.number = number
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
