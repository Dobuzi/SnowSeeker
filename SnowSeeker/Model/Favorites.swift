//
//  Favorites.swift
//  SnowSeeker
//
//  Created by 김종원 on 2020/11/15.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"
    
    init() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName: URL = path.appendingPathComponent(self.saveKey)
        
        if let data = try? Data(contentsOf: fileName) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                self.resorts = decoded
                return
            }
        }
        
        self.resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    private func save() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName: URL = path.appendingPathComponent(self.saveKey)
        
        do {
            let encoded = try? JSONEncoder().encode(self.resorts)
            try encoded?.write(to: fileName, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save the favorites data.")
        }
    }
}
