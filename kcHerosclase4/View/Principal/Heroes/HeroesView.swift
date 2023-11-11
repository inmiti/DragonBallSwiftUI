//
//  HeroesView.swift
//  kcHerosclase4
//
//  Created by ibautista on 6/11/23.
//

import SwiftUI

struct HeroesView: View {
    @StateObject var viewModel: viewModelHeros
    @State private var filter: String = ""
    @EnvironmentObject var viewModelRoot: RootViewModel
    var body: some View {
        NavigationStack{
            List{
                if let heroes = viewModel.heros {
                    ForEach(heroes){data in
                        NavigationLink {
                            //Destino
                            HeroesDetailView(hero: data)
                        } label: {
                            //La celda personalizada
                            HeroesRowView(hero: data)
                                .frame(height: 200)
                        }
                    }
                }
            }
            .navigationTitle("Heros")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        //Close session
                        viewModelRoot.CloseSession()
                    }, label: {
                        HStack{
                            Image(systemName: "xmark.circle")
                            Text("Close")
                                .font(.caption)
                        }
                    })
                }
            }
            
        }
        .searchable(text: $filter,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Buscar héroes...")
        .onChange(of: filter) { newValue in
            viewModel.getHeros(filter: newValue )
        }
    }
}

struct HeroesView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesView(viewModel: viewModelHeros(testing: true))
    }
}
