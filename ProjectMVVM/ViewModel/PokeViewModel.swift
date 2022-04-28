//
//  PokeViewModel.swift
//  ProjectMVVM
//
//  Created by Linder Anderson Hassinger Solano    on 22/04/22.
//

import Foundation

class PokeViewModel {
    
    var pokemons = [Result]()
    
    var pokemon: PokeDetail? = nil
    
    let URL_API: String = "https://pokeapi.co/api/v2/pokemon?limit=100"
    
    func getDataFromAPI() async {
        do {
            let (data, _) = try await URLSession.shared.data(from: HelperString.getURLFromString(url: URL_API)!)
            
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
    }
    
    // Functio get info from url
    func getPokeDetail(url: String) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: HelperString.getURLFromString(url: url)!)
            
            if let decoder = try? JSONDecoder().decode(PokeDetail.self, from: data) {
                DispatchQueue.main.async(execute: {
                    self.pokemon = decoder
                })
            }
        } catch {
            print("error found")
        }
    }
}
