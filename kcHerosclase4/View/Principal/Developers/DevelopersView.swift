//
//  DevelopersView.swift
//  kcHerosclase4
//
//  Created by ibautista on 11/11/23.
//

import SwiftUI

struct DevelopersView: View {
    @StateObject var viewModel: ViewModelDevelpers
    @EnvironmentObject var viewModelRoot: RootViewModel
    
    var body: some View {
        ScrollView{
            if let boots = viewModelRoot.bootcamps,
               let devs = viewModel.developers{
                
                ForEach(boots) { boot in
                    // filtrar por developers
                    let devsBoot =
                        devs.filter { $0.bootcamp.id == boot.id
                        }
                    //Título
                    if devsBoot.count > 0 {
                        VStack(alignment: .leading){
                            Text(boot.name)
                                .font(.title)
                                .foregroundStyle(.orange)
                                .bold()
                            
                             //lista scroll view horizontal
//                            ScrollView(.horizontal, showIndicators: false) {
//                                LazyHStack{
//                                    ForEach(devsBoot) { devBoot in
//                                        let _ = print("\(devBoot.id)")
//
//                                        //subview
//                                        VStack{
//                                            //foto
//                                            AsyncImage(url: URL(string: devBoot.photo)) { photo in
//                                                photo
//                                                    .resizable()
//                                                    .frame(width: 100, height: 100)
//                                                    .cornerRadius(50)
//                                                    .padding()
//                                            } placeholder: {
//                                                Image(systemName: "person")
//                                                    .resizable()
//                                                    .frame(width: 100, height: 100)
//                                                    .padding()
//                                            }
//
//                                            Text(devBoot.name)
//
//                                        }
//                                        .onTapGesture(count: 2) {
//                                            //Lo que queramos mostrar
//                                            let _ = print("\(devBoot.name )")
//                                        }
//
//                                    }
//                                }
//
//                            }
                        }
                    }
                    }
            } else {
                Text("No hay datos")
            }
        }
    
    }
}

struct DevelopersView_Previews: PreviewProvider {
    static var previews: some View {
        let root = RootViewModel(testing: true)
        DevelopersView(viewModel: ViewModelDevelpers(testing: true, boots: root.bootcamps!))
            .environmentObject(root)
    }
}
