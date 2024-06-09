//  EditMenuView.swift

import SwiftUI
import QCropper

struct EditMenuView: View {
    
    @EnvironmentObject var shared:PECtl
    @State var currentView:EditView = .lut
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        GeometryReader { geometry in
            VStack{
                if((self.currentView == .filter && self.shared.currentEditMenu != .none) == false
                   && self.shared.lutsCtrl.editingLut == false){
                    Spacer().frame(height: 10)
                    HStack(spacing: 48){
                        
                        Spacer().frame(width: 40)
                        //MARK: - Cropper Button
                        NavigationLink(destination:
                                        CustomCropperView()
                                        .navigationBarTitle("")
                                        .navigationBarHidden(true)
                        ){
                            IconButton("adjustment", size: 36)
                                .colorMultiply(Color("button-color"))
                        }
                        
                        //MARK: - Filter Button
                        Button(action:{
                            self.currentView = .lut
                        }){
                            IconButton("edit-lut")
                                .colorMultiply(self.currentView == .lut ? Color("primary") : Color("button-color"))
                        }
                        
                        //MARK: - Edit Button
                        Button(action:{
                            if(self.shared.lutsCtrl.loadingLut == false){
                                self.currentView = .filter
                                self.shared.didReceive(action: PECtlAction.commit)
                            }
                        }){
                            IconButton("edit-color")
                                .colorMultiply(self.currentView == .filter ? Color("primary") : Color("button-color"))
                        }
                        
                        //MARK: - Recipe Button
                       /* Button(action:{
                            self.currentView = .recipe
                        }){
                            IconButton(self.currentView == .recipe ? "edit-recipe-highlight" : "edit-recipe")
                        } */
                        
                        Spacer()
                        Button(action:{
                            self.shared.didReceive(action: PECtlAction.undo)
                        }){
                            IconButton("icon-undo-new2", size: 27)
                                .colorMultiply(Color("button-color"))
                        }
                        Spacer().frame(width: 40)

                    }// ends of HStack(butons)
                    .frame(width: geometry.size.width, height: 50)
                    // Edit butonlarının olduğu HStack color
                    .background(Color.myPanel)
                    .cornerRadius(80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 80)
                            .stroke(Color(red: 0.71, green: 0.71, blue: 0.71).opacity(colorScheme == .light ? 0.2: 0), lineWidth: 1)
                    )
                    .shadow(color: Color(red: 0.71, green: 0.71, blue: 0.71).opacity(0.25), radius: 5, x: 0, y: -2)
                }
                Spacer()
                ZStack{
                    if(self.currentView == .filter){
                        FilterMenuUI()
                    }
                    if(self.currentView == .lut){
                        LutMenuUI()
                    }
                   /* if(self.currentView == .recipe){
                        RecipeMenuUI()
                    }*/
                }
                Spacer()
            }
        }
    }
}

public enum EditView{
    case lut
    case filter
   // case recipe
}

struct EditMenuView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoEditorView()
            .environmentObject(PECtl())
    }
}

