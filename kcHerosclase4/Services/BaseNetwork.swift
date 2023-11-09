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
}
