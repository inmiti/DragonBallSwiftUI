//
//  HeroesDetailView.swift
//  kcHerosclase4
//
//  Created by ibautista on 11/11/23.
//

import SwiftUI

struct HeroesDetailView: View {
    var hero: Heros
//    @ObservedObject var viewModelHeros: viewModelHeros
    var body: some View {
        VStack{
            HStack{
                //Name
                Text(hero.name)
                    .bold()
                    .font(.title)
                Spacer()
                //like
                Button(action: {
                    
                }, label: {
                   
                    if (hero.favorite!){
                        Image(systemName: "heart.circle")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 40, height: 40)
                            .padding([.leading], 10)
                    } else{
                        Image(systemName: "heart.circle")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .padding([.leading], 10)
                    }
                })
            }
            .padding([.leading, . trailing], 10)
            
            //photo
            AsyncImage(url: URL(string: hero.photo)) { photo in
                photo
                    .resizable()
                    .cornerRadius(20)
                    .opacity(0.8)
                    .padding([.leading, .trailing], 10)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .cornerRadius(20)
                    .foregroundColor(.gray)
                    .opacity(0.8)
            }
            //Description
            Text(hero.description)
                .foregroundColor(.gray)
                .font(.caption)
            
        }
    }
}

struct HeroesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesDetailView(hero: Heros(id: UUID(), name: "Goku", description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.", photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300", favorite: false))
    }
}
