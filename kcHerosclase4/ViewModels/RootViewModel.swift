//
//  RootViewModel.swift
//  kcHerosclase4
//
//  Created by ibautista on 6/11/23.
//

import Foundation
import Combine

public let CONST_TOKEN_ID = "TokenJWTAppiOSBoot166"

final class RootViewModel: ObservableObject {
    @Published var status = Status.none  //estado por defecto
    var isLogged: Bool = false  //indica si está o no logeado el usuario
    
    //token del login
    /*
    @Published var tokenJWT: String = ""
     {
        didSet{
            print("llega el login: \(tokenJWT)")
            saveKC(key: CONST_TOKEN_ID, value: tokenJWT) //No tengo que poner el _ = porque le puese a la funcion el @discardableResult

            if tokenJWT.count > 0 {
                isLogged = true
            } else {
                isLogged = false
            }
        }
    }
     */
    
    @kcPersistenceKeyChain(key: CONST_TOKEN_ID)
    var tokenJWT {
        didSet{
            print("token: \(tokenJWT)")
        }
    }
    
    //combine
    var suscriptors = Set<AnyCancellable>()
    //inicializador
    init(){
        self.LogedUserControl() //control de si está logado
    }

    //Cierre de sesión
    func CloseSession() {
        tokenJWT = ""
        status = .none
    }
    //Control de usuario conectado
    func LogedUserControl(){
        /*
         let tokenOptional = loadKC(key: CONST_TOKEN_ID) //leo el token
        if let token = tokenOptional {
            tokenJWT = token //asigno el token guardado
            status = .loaded
        }
         */
        if tokenJWT != ""{
            status = .loaded
        }
    }
    
    //Login al servidor
    func login(user: String, password: String) {
        status = .loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionLogin(user: user, password: password))
            .tryMap {
                //Evaluamos si es 200 y devolvemos JSON, si no exception
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                //Todo ok: convierto data ->  String
                return String(decoding: $0.data, as: UTF8.self)
            }
            .receive(on: DispatchQueue.main) //Hilo principal
            .sink { completion in
                //Evaluamos la respuesta
                switch completion {
                case .failure:
                    self.status = .error(error: "Usuario y/o clave errónea")
                    
                case .finished:
                    self.status = .loaded //Login ok
                }
            } receiveValue: { token in
                self.tokenJWT = token
                print("Token: \(token)")
            }
            .store(in: &suscriptors)
    }
}
