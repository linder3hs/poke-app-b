//
//  PokeViewModel.swift
//  ProjectMVVM
//
//  Created by Linder Anderson Hassinger Solano    on 22/04/22.
//

import Foundation

class PokeViewModel {
    
    var pokemons = [Result]()
    
    let URL_API: String = "https://pokeapi.co/api/v2/pokemon"
    
    func getDataFromAPI() async {
        // Pasa1: Convertir el string a URL
        guard let url = URL(string: URL_API) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decoder = try? JSONDecoder().decode(Pokemon.self, from: data) {
                DispatchQueue.main.async(execute: {
                    decoder.results.forEach { pokemon in
                        // Estamos agregando cada pokemon al array pokemons
                        self.pokemons.append(pokemon)
                    }
                })
            }
        } catch {
            print("error found")
        }
        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            // Haremos una validacion para saber si data sea valido
//            if let data = data {
//                let decode = String(data: data, encoding: .utf8)
//                print(decode!)
//            }
//        }
//        task.resume()
    }
}
