//
//  SwiftUIView.swift
//  ContactList
//
//  Created by Сергей Веретенников on 22/05/2022.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        VStack(spacing: 40) {
            Image("Me")
                .resizable()
                .frame(width: 300, height: 428)
                .cornerRadius(30)
                .padding(.top, 30)
                .addShadow()
            Text("Тестовый проект начинающего разраба приложений под IOS, Веретенникова Сергея Вячеславовича. \n\nP.S. Сверху моя морда \n P.S.S При разработке ни одна нервная клетка не пострадала")
                .frame(width: 300)
                .multilineTextAlignment(.center)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
