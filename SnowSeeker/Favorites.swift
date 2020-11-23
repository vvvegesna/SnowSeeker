//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Vegesna, Vijay V EX1 on 11/15/20.
//

import SwiftUI

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>
    private var storedResorts: [String] {
        Array(resorts)
    }
    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        // load our saved data
        if let myFavorites = UserDefaults.standard.object(forKey: "myFavorites") as? [String] {
            self.resorts = Set(myFavorites.map { $0 })
            return
        }
        // still here? Use an empty array
        self.resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        // write out our data
        UserDefaults.standard.set(storedResorts, forKey: "myFavorites")
    }
}
