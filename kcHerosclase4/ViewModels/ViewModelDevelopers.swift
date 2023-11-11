//
//  ViewModelDevelopers.swift
//  kcHerosclase4
//
//  Created by ibautista on 11/11/23.
//

import Foundation
import Combine

final class ViewModelDevelpers: ObservableObject{
    @Published var developers: [DeveloperModel]?
    var status = Status.none //para spiners
    
    var suscriptors = Set<AnyCancellable>()
    
    init(testing: Bool = false, boots: [Bootcamp] = []){
        if (testing) {
            getDevelopersTesting(boots: boots)
        } else {
            getDevelopers()
        }
    }
    
    func getDevelopers(){
        self.status = .loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionDeveloper())
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
            .decode(type: [DeveloperModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure:
                    self.status = .error(error: "Error buscando developers")
                case .finished:
                    self.status = .loaded //Success
                }
            } receiveValue: { data in
                self.developers = data
                
            }
            .store(in: &suscriptors)
    }
    
    func getDevelopersTesting(boots:[Bootcamp]){
        
        //Creo 2 bootcamps
        let b1 = Bootcamp(id: boots[0].id, name: boots[0].name)
        let b2 = Bootcamp(id: boots[1].id, name: boots[1].name)
        
        //Creo varios developers
        let d1 = DeveloperModel(apell1: "Martinez", apell2: "Gomez", id: "0101", email: "jlbustos1@keepcoding.es", photo: "https://media-exp1.licdn.com/dms/image/C5603AQFAargIfS-A4A/profile-displayphoto-shrink_200_200/0/1517710838821?e=1626912000&v=beta&t=wZ2Km9X6nWEOWo95Fu58D14OvIMdwhXtiOzQe4QIaVc", name: "Manuel", bootcamp: b1, heros: [])
                
        let d2 = DeveloperModel(apell1: "GArcia", apell2: "Fernandez", id: "0102", email: "jlbustos1@keepcoding.es", photo: "https://media-exp1.licdn.com/dms/image/C5603AQFAargIfS-A4A/profile-displayphoto-shrink_200_200/0/1517710838821?e=1626912000&v=beta&t=wZ2Km9X6nWEOWo95Fu58D14OvIMdwhXtiOzQe4QIaVc", name: "Inma", bootcamp: b1, heros: [])
        
        let d3 = DeveloperModel(apell1: "Gomez", apell2: "Lopez", id: "0103", email: "jlbustos1@keepcoding.es", photo: "https://media-exp1.licdn.com/dms/image/C5603AQFAargIfS-A4A/profile-displayphoto-shrink_200_200/0/1517710838821?e=1626912000&v=beta&t=wZ2Km9X6nWEOWo95Fu58D14OvIMdwhXtiOzQe4QIaVc", name: "Francisco", bootcamp: b1, heros: [])
        
        let d4 = DeveloperModel(apell1: "Bustos", apell2: "Esteban", id: "0104", email: "jlbustos1@keepcoding.es", photo: "https://media-exp1.licdn.com/dms/image/C5603AQFAargIfS-A4A/profile-displayphoto-shrink_200_200/0/1517710838821?e=1626912000&v=beta&t=wZ2Km9X6nWEOWo95Fu58D14OvIMdwhXtiOzQe4QIaVc", name: "Ana maria", bootcamp: b2, heros: [])
        
        let d5 = DeveloperModel(apell1: "Bautista", apell2: "Vélez", id: "0105", email: "inmabauvel@gmail.com", photo: "", name: "Inma", bootcamp: b2, heros: [])
            
        self.developers = [d1,d2,d3,d4]
        }
}
