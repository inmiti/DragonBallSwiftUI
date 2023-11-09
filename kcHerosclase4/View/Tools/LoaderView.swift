//
//  LoaderView.swift
//  kcHerosclase4
//
//  Created by ibautista on 6/11/23.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        Image(systemName: "clock")
            .resizable()
            .frame(width: 100, height: 100)
        
        Text("Por favor espere ....")
            .font(.title)
            .padding()
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
