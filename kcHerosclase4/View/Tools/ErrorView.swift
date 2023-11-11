//
//  ErrorView.swift
//  kcHerosclase4
//
//  Created by ibautista on 6/11/23.
//

import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    
    private var textError: String
    
    init(error:String){
        self.textError = error
    }
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 200, height: 200)
                .padding()
            Text("\(textError)")
                .font(.title2)
                .foregroundColor(.red)
                .bold()
                .padding()
            
            Spacer()
            
            //Button
            Button(action: {
                //acción
                rootViewModel.status  = .none //volvemos a login
            }, label: {
                Text("Volver")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(.orange)
                    .cornerRadius(20)
                    .shadow(radius: 10, x:20, y:10)
            })
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: "Esto es una prueba de error")
            .environmentObject(RootViewModel())
    }
}
