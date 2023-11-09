//
//  PropertyWrappers.swift
//  kcHerosclase4
//
//  Created by ibautista on 6/11/23.
//

import Foundation

//persistencia en keychain
@propertyWrapper
class kcPersistenceKeyChain {
    private var key: String
    
    init(key: String) {
        self.key = key
    }
    
    var wrappedValue: String {
        get {
            if let value = loadKC(key: key) {
                return value
            } else {
                return ""
            }
        }
        set{
            //Grabar
            saveKC(key: key, value: newValue)
        }
    }
}
