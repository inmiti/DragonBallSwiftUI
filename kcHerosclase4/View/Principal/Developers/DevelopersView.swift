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
               let _ = viewModel.developers{
                ForEach(boots) { boot in
                    Text(boot.name)
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
