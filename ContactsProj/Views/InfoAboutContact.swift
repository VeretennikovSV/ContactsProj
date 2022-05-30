//
//  InfoAboutContact.swift
//  ContactList
//
//  Created by Сергей Веретенников on 23/05/2022.
//

import SwiftUI

struct InfoAboutContact: View {
    
    @Environment(\.dismiss) var presentationMode
    @Environment(\.managedObjectContext) var context
    
    @State private var name = ""
    @State private var secondName = ""
    @State private var number = ""
    @State private var photo: Data?
    @State private var barTitle = ""
    let contact: Contact
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ImageButton(data: $photo,uiimage: UIImage(data: photo ?? Data()), contact: contact)
                        .padding(.top, 40)
                    TextFieldView(textInTF: $number, placeHolder: "Phone numberr", name: "Phone")
                        .focused($focusedField, equals: .phone)
                        .simultaneousGesture(TapGesture().onEnded {
                            focusedField = .phone
                        })
                        .padding(.top, 80)
                        .overlay(Button {
                            let callPhone = "tel://"
                            let formatedCall = callPhone + number
                            guard let url = URL(string: formatedCall) else { return }
                            UIApplication.shared.open(url)
                        } label: {
                            Image(systemName: "phone")
                        }
                            .position(x: 270, y: 97)
                        )
                    TextFieldView(textInTF: $name, placeHolder: "Contact's name", name: "Name")
                        .focused($focusedField, equals: .name)
                        .simultaneousGesture(TapGesture().onEnded {
                            focusedField = .name
                        })
                    TextFieldView(textInTF: $secondName, placeHolder: "Contact's last name", name: "Last name")
                        .focused($focusedField, equals: .secondName)
                        .simultaneousGesture(TapGesture().onEnded {
                            focusedField = .secondName
                        })
                    Spacer()
                }
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height - 200
                )
                .toolbar {
                    Button {
                        saveContact()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            focusedField = nil
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            presentationMode()
                        }
                    } label: {
                        Text("Save").bold()
                    }
                }
                .navigationTitle(barTitle)
            }
        }
        .onAppear {
            name = contact.name
            barTitle = contact.name
            secondName = contact.secondName
            number = contact.number
            photo = contact.picture
        }
        .onTapGesture {
            focusedField = nil
        }
    }
    private func saveContact() {
        contact.name = name
        contact.secondName = secondName
        contact.number = number
        print("Changed")
        
        do {
            try context.save()
            barTitle = name
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct InfoAboutContact_Previews: PreviewProvider {
    static var previews: some View {
        InfoAboutContact(contact: Contact())
    }
}


