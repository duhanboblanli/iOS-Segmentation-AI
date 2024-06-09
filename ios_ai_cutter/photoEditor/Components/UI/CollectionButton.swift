//
//  CollectionButton.swift
//  colorful-room
//
//  Created by macOS on 7/16/20.
//  Copyright © 2020 PingAK9. All rights reserved.
//

import SwiftUI

struct CollectionButton: View {
    var name:String
    
    @EnvironmentObject var shared:PECtl
    
    var body: some View {
        Text(name)
            .font(.custom(FontsManager.Poppins.medium, size: 15))
            .foregroundColor(Color("butonTitleColor"))
    }
}
