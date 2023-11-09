//
//  LoginView.swift
//  kcHerosclase4
//
//  Created by ibautista on 6/11/23.
//

import SwiftUI

struct LoginView: View {
    // Instancia del enviroment
    @EnvironmentObject var rootViewModel: RootViewModel
    
#if DEBUG
    @State private var email = "inmabauvel@gmail.com"
    @State private var password = "123456"
#else
    @State private var email = ""
    @State private var password = ""
#endif
    
    var body: some View {
        ZStack{
            //Imagen de fondo
            Image(decorative: "backgroundLogin")
                .resizable()
                .opacity(1)
            //Capa ocurecer imagen
            Image(decorative: "")
                .resizable()
                .background(.black)
                .opacity(0.3)
            
            //Image logo
            
            VStack{
                Image(decorative: "title")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.8)
                    .padding(.top, 160)
                Spacer()
                
                VStack{
                    TextField("Usuario", text: $email)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(20)
                        .shadow(radius: 10.0, x:40, y:20)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .opacity(0.8)
                        .id(1) // for testing
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(20)
                        .shadow(radius: 10.0, x:40, y:20)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .opacity(0.8)
                        .padding(.top, 20)
                        .id(2) // for testing
                    
                    //Botón de login
                    Button {
                        rootViewModel.login(user: email, password: password)
                    } label: {
                        Text("Entrar")
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color(uiColor: UIColor(red: 221.0/255.0, green: 99.0/255.0, blue: 0.0, alpha: 1.0)))
                            .cornerRadius(20)
                            .shadow(radius: 10, x:20, y:20)
                    }
                    .padding(.top, 50)
                    .opacity(0.8)
                    .id(3)

                }
                .padding([.leading, .trailing], 16)
                Spacer()
                
                //Link del registro
                HStack{
                    Text("¿No tienes cuenta?")
                        .foregroundColor(.white)
                        .bold()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Registro")
                            .foregroundStyle(.blue)
                    })
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environment(\.locale, .init(identifier: "en"))
            .preferredColorScheme(.light)
//            .preferredColorScheme(.light)
        //.environment(\.locale, .init(identifier: "es"))
    }
}
