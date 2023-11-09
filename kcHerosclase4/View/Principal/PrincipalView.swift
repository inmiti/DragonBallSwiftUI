//
//  PrincipalView.swift
//  kcHerosclase4
//
//  Created by ibautista on 6/11/23.
//

import SwiftUI

struct PrincipalView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    var body: some View {
        VStack{
            
//            Text("Hola somos la Home")
//
//            Button(action: {
//                rootViewModel.CloseSession()
//            }, label: {
//                Text("Cerrar sesion")
//            })
            
            VStack{
                Text("Lista heroes")
            }
            .tabItem {
                Image(systemName: "house")
            }
        }
    }
}

struct PrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        PrincipalView()
            .environmentObject(RootViewModel())
    }
}
