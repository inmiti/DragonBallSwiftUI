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
            }
            .tabItem {
                Image(systemName: "house")
                Text("Héroes")
            }
            DevelopersView(viewModel: ViewModelDevelpers())
                .tabItem {
                    Image(systemName: "person")
                    Text("Developers")
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
