//
//  Poke+Image.swift
//  ProjectMVVM
//
//  Created by Linder Anderson Hassinger Solano    on 23/04/22.
//

import Foundation
import UIKit

class HelperImage {
    
    static func setImage(id: String) -> UIImage? {
        let url = URL(string: getUrlImage(id: id))
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            return UIImage(data: imageData)
        }
        
        return nil
    }
    
    static func getUrlImage(id: String) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}
