//
//  ReadData.swift
//  Pirarucool
//
//  Created by Guilherme Ferreira Lenzolari on 26/04/24.
//

import Foundation

class MenuViewModel: ObservableObject  {
    @Published var pratos = [Prato]()
    
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "Pratos", withExtension: "json") else {
            print("Json file not found")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let pratos = try JSONDecoder().decode([Prato].self, from: data)
            self.pratos = pratos
        } catch {
            print("Error loading JSON:", error)
        }
    }
    
    
}
