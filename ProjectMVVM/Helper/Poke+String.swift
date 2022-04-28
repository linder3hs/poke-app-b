//
//  Poke+String.swift
//  ProjectMVVM
//
//  Created by Linder Anderson Hassinger Solano    on 23/04/22.
//

import Foundation

class HelperString {
    
    static func getIdFromUrl(url: String) -> String {
        // js: url.split("/").filter(element => element != "").pop()
        // swift: url.components(separatedBy: "/").filter({ $0 != ""}).last!
        return url.components(separatedBy: "/").filter({ $0 != ""}).last!
    }
    
    static func getURLFromString(url: String) -> URL? {
        guard let url = URL(string: url) else { return nil }
        
        return url
    }
}

