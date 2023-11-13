//
//  kcHerosclase4Tests.swift
//  kcHerosclase4Tests
//
//  Created by ibautista on 6/11/23.
//

import XCTest
import SwiftUI
import ViewInspector
import Combine

@testable import kcHerosclase4

final class kcHerosclase4Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModelos() throws {
        let model = Heros(id: UUID(), name: "Jose", description: "", photo: "", favorite: true)
        XCTAssertNotNil(model)
        XCTAssertEqual(model.name, "Jose")
        XCTAssertEqual(model.getFullName(), "BB Jose")
        
        let modelRequest = HeroFilter(name: "Goku")
        XCTAssertNotNil(modelRequest)
        XCTAssertEqual(modelRequest.name, "Goku")
    }
    
    func testUIViews() throws {
        let view = ErrorView(error: "Hola") //Instanciamos la view
            .environmentObject(RootViewModel(testing: true))
        
        XCTAssertNotNil(view)
        
        let numItems = try view.inspect().count
        XCTAssertEqual(numItems, 1)
        
        //Imagen
        let img = try view.inspect().find(viewWithId: 0)
        XCTAssertNotNil(img)
        
        //Texto
        let text = try view.inspect().find(viewWithId: 1)
        XCTAssertNotNil(text)
        
        let texto = try text.text().string()
        XCTAssertEqual(texto, "Hola")
        
        //Boton
        let button = try view.inspect().find(viewWithId: 2)
        XCTAssertNotNil(button)
        
        //Ejecutar el botón
        try button.button().tap() //ejectuto el botón
        
    }
    
    func testViewModelBootcamps() throws{
        let expectation = self.expectation(description: "Descarga de bootcamps")
        var suscriptor = Set<AnyCancellable>()
        
        //Instancio viewModel:
        let vm = RootViewModel(testing: true)
        XCTAssertNotNil(vm)
        
        //Creo el observador
        vm.bootcamps.publisher
            .sink { completion in
                switch completion{
                case .finished:
                    XCTAssertEqual(1, 1) //test ok
                    expectation.fulfill()
                case .failure:
                    XCTAssertEqual(1, 2) //genero el fallo
                    expectation.fulfill()
                }
            } receiveValue: { data in
                XCTAssertEqual(1, 1)
            }
            .store(in: &suscriptor)

        //lanzamos la load
        vm.loadBootcampsTesting()
        
        //esperamos x segundos
        self.waitForExpectations(timeout: 10)
    }
    
    
    func testViewModelHeroes() throws{
        let expectation = self.expectation(description: "Descarga de heroes")
        var suscriptor = Set<AnyCancellable>()
        
        //Instancio viewModel:
        let vm = viewModelHeros(interactor: HerosInteractorFake())
        XCTAssertNotNil(vm)
        
        //Creo el observador
        vm.heros.publisher
            .sink { completion in
                switch completion{
                case .finished:
                    //test ok
                    print("Terminada la carga de heroes")
                    
                case .failure:
                    XCTAssertEqual(1, 2) //genero el fallo
                    expectation.fulfill()
                }
            } receiveValue: { heros in
                XCTAssertEqual(heros.count, 4)
                expectation.fulfill()
            }
            .store(in: &suscriptor)

        //lanzamos la load porque el constructor de viewModel ya lo hace
     
        //esperamos x segundos
        self.waitForExpectations(timeout: 10)
    }

}
