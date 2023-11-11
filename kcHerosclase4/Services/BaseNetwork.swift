//
//  BaseNetwork.swift
//  kcHerosclase4
//
//  Created by ibautista on 6/11/23.
//

import Foundation

//constantes
let server = "https://dragonball.keepcoding.education"

//struct de métodos de red
struct HTTPMethods {
    static let post = "POST"
    static let get = "GET"
    static let put = "PUT"
    static let delete = "DELETE"
    
    static let content = "application/json"
    static let contentType = "Content-type"
}

enum endpoints: String {
    case login = "/api/auth/login"
    case herosList = "/api/heros/all"
    case developerList = "/api/data/developers"
    case bootcampsList = "/api/data/bootcamps"
}

struct BaseNetwork {
    func getSessionLogin(user: String, password: String) -> URLRequest {
        let urlS = "\(server)\(endpoints.login.rawValue)"
        let encodeCredentials = "\(user):\(password)".data(using: .utf8)?.base64EncodedString()
        
        var sefCredential = ""
        if let credentials = encodeCredentials {
            sefCredential = "Basic \(credentials)"
        }
        
        //Crear request
        var request: URLRequest = URLRequest(url: URL(string: urlS)!)
        request.httpMethod = HTTPMethods.post
        request.addValue(HTTPMethods.content, forHTTPHeaderField: HTTPMethods.contentType)
        request .addValue(sefCredential, forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func getSessionHero(filter: String) -> URLRequest{
        let urlCad = "\(server)\(endpoints.herosList.rawValue)"
        
        var request: URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post
        
        //generamos el JSON y lo metemos en el body de la llamada
        request.httpBody = try? JSONEncoder().encode(HeroFilter(name: filter))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        
        //seguridad JWT
        let tokenOptional = loadKC(key: CONST_TOKEN_ID)
        if let tokenJWT = tokenOptional {
            request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
    
    func getSessionDeveloper() -> URLRequest{
        let urlCad = "\(server)\(endpoints.developerList.rawValue)"
        
        var request: URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.get
        
        //seguridad JWT
        let tokenOptional = loadKC(key: CONST_TOKEN_ID)
        if let tokenJWT = tokenOptional {
            request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
    
    func getSessionBootcamps() -> URLRequest{
        let urlCad = "\(server)\(endpoints.bootcampsList.rawValue)"
        
        var request: URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.get
        
        return request
    }
}
