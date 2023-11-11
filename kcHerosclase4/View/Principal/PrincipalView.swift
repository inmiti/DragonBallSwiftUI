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
        TabView{     
            VStack{
                HeroesView(viewModel: viewModelHeros(testing: false))
                Button(action: {
                    rootViewModel.CloseSession()
                }, label: {
                    Text("Cerrar sesion")
                })
            }
            .tabItem {
                Image(systemName: "house")
                Text("Héroes")
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
