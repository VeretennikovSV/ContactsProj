//
//  ImageView.swift
//  ContactsProj
//
//  Created by Сергей Веретенников on 26/05/2022.
//

import SwiftUI

struct ImageButton: View {
    
    @Environment(\.managedObjectContext) var context
    
    @State private var image: Image?
    @Binding var data: Data?
    @State var uiimage: UIImage?
    @State private var focusedImaagePicker = false
    var contact: Contact
    
    func save() {
        let pickedImage = uiimage?.jpegData(compressionQuality: 0.8)
        
        data = pickedImage
        contact.picture = data
        
        do {
            try context.save()
        } catch {
            print(2)
        }
    }
    
    func loadImage() {
        guard let uiimage = uiimage else { return }
        image = Image(uiImage: uiimage)
        
        save()
    }
    
    var body: some View {
        Button {
            self.focusedImaagePicker = true
        } label: {
            ZStack {
            Circle()
                .foregroundColor(.gray)
                .frame(width: 200, height: 200)
                if let data = data {
                    Image(uiImage: UIImage(data: data)!)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(100)
                        .scaledToFit()
                } else {
                    Image(systemName: "questionmark")
                        .resizable()
                        .frame(width: 30, height: 50)
                }
            }
        }
        .sheet(isPresented: $focusedImaagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$uiimage)
        }
    }
}