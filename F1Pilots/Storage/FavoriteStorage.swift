//
//  FavoriteStorage.swift
//  F1Pilots
//
//  Created by Mustafa Berkan Vay on 19.04.2022.
//

import Foundation

class FavoriteStorage {
    private static let userDefaultsKey = "favoritedIds"
    
    private static var ids: [Int] {
        get {
            UserDefaults.standard.object(forKey: userDefaultsKey) as? [Int] ?? []
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
        }
    }
    
    static func add(id: Int) {
        if contains(id: id) { return }
        
        ids.append(id)
    }
    
    static func remove(id: Int) {
        ids.removeAll { $0 == id }
    }
    
    static func contains(id: Int) -> Bool {
        ids.contains(id)
    }
}
