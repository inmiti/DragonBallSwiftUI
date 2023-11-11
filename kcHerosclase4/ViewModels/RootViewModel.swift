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
    
    @Published var bootcamps: [Bootcamp]?
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
    init(testing: Bool = false){
        self.LogedUserControl() //control de si está logado
        
        //Cargamos los boots si no estamos en testing o diseño
        if(!testing){
            self.loadBootcamps()
        } else {
            loadBootcampsTesting()
        }
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
    
    func loadBootcamps() {
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionBootcamps())
            .tryMap{
                //evaluamos si es 200, sino lo es Exception. Si es 200 pues devilvemos el JSON que es el data
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    //error
                    throw URLError(.badServerResponse)
                }
                
                //Todo OK. Devuelvo Data
                return $0.data
            }
            .decode(type: [Bootcamp].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure:
                    self.status = .error(error: "Error buscando bootcamps")
                case .finished:
                    self.status = .loaded //Success
                }
            } receiveValue: { data in
                self.bootcamps = data
                
            }
            .store(in: &suscriptors)
    }
    
    //Testing o diseño de UI
    func loadBootcampsTesting(){
        let b1 = Bootcamp(id: UUID().uuidString, name: "boot mobile 1")
        let b2 = Bootcamp(id: UUID().uuidString, name: "boot mobile 2")
        let b3 = Bootcamp(id: UUID().uuidString, name: "boot mobile 3")
        let b4 = Bootcamp(id: UUID().uuidString, name: "boot mobile 4")
        
        self.bootcamps = [b1, b2, b3, b4]
    }
}
