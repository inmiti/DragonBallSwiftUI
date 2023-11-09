//
//  Keychain.swift
//  kcHerosclase4
//
//  Created by ibautista on 6/11/23.
//

import KeychainSwift

//Guardamos
@discardableResult //El que lo llama puede usarlo o no
func saveKC(key: String, value: String) -> Bool {  // Lo suyo en solid no es una función.
    //Convirtiendo cadena value en data utf8
    if let data = value.data(using: .utf8) { //No aceptar caracteres raros, hay que pasar antes a utf8
        let kc = KeychainSwift()
        return kc.set(data, forKey: key) //Devuelve bool si graba satisfactoriamente el data.
    } else {
        //No desempaqueta
        return false
    }
}

// Leemos
func loadKC(key: String) -> String? {
    if let data = KeychainSwift().get(key) {
        return data
    } else {
        return ""
    }
}

//Borramos
func deleteKC(key: String) -> Bool {
    KeychainSwift().delete(key)  //solo una línea de código no es necesario el return
}
