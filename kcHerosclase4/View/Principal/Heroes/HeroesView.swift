//
//  HeroesView.swift
//  kcHerosclase4
//
//  Created by ibautista on 6/11/23.
//

import SwiftUI

struct HeroesView: View {
//    @StateObject var viewModel: viewModelHeroes
//    @StateObject private var filter: String = ""
    var body: some View {
        Text("Listado de héroes")
//        NavigationStack{
//            List{
//                if let heroes = viewModel.heros {
//                    ForEach(heroes){
//                        NavigationLink {data in
//                            //Destino
//                        } label: {
//                            //La celda personalizada
//                            HeroesRowView(hero: data)
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Heros")
//        }
//        .searchable(text: $filter,
//                    placement: .navigationBarDrawer(displayMode: .always),
//                    prompt: "Buscar héroes...")
//        .onChange(of: filter) { oldValue, newValue in
//            viewModel.getHeros(filter: newValue )
//        }
    }
}

struct HeroesView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesView()
    }
}
