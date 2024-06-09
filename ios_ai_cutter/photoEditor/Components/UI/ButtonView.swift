//
//  ButtonView.swift
//

import SwiftUI

// Edit Butons
struct ButtonView: View {
    
    var action:FilterModel
    
    @EnvironmentObject var shared:PECtl
    
    var body: some View {
        Button(action: {
            self.shared.currentFilter = self.action
        }){
            VStack(spacing: 4){
                IconButton(self.action.image, size: 39)
                    .colorMultiply(Color("button-color"))
                Text(self.action.name)
                    .font(.custom(FontsManager.Poppins.medium, size: 13))
                    .foregroundColor(Color("butonTitleColor"))
                    .padding(.top)
            }
            .frame(minWidth: 75)
        }
    }
}
