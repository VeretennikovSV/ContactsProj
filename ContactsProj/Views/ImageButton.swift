//
//  ImageView.swift
//  ContactsProj
//
//  Created by Сергей Веретенников on 26/05/2022.
//

import SwiftUI

struct ImageButton: View {
    
    @Environment(\.managedObjectContext) var context
    
    @Binding var data: Data?
    
    @State private var image: Image?
    @State private var focusedImaagePicker = false
    
    @State var uiimage: UIImage?
    
    var contact: Contact
    
    func save() {
        let pickedImage = uiimage?.jpegData(compressionQuality: 1)
        
        data = pickedImage
        contact.picture = data
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
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
                    .frame(width: 175, height: 175)
                    .foregroundColor(.gray)
                    .opacity(0.7)
                    .addShadow()
                if let data = data {
                    Image(uiImage: UIImage(data: data)!)
                        .resizable()
                        .frame(width: 175, height: 175)
                        .cornerRadius(87)
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
