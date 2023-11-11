//
//  RootView.swift
//  kcHerosclase4
//
//  Created by ibautista on 6/11/23.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    var body: some View {
        //Status Box o ViewRouter
        switch rootViewModel.status {
            case Status.none:
                withAnimation {
                    LoginView() //Login
                }
            case .register:
                Text("Registro")
            case .loading:
                withAnimation {
                    LoaderView()
                }
            case .error(error: let errorString):
                withAnimation {
                    ErrorView(error: errorString)
                }
            case .loaded:
                withAnimation {
                    PrincipalView()
                }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(RootViewModel())
    }
}
