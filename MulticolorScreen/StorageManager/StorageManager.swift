//
//  StorageManager.swift
//  MulticolorScreen
//
//  Created by Marat Shagiakhmetov on 05.07.2023.
//

import UIKit

class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "background"
    
    func saveBackground(color: Color) {
        var background = fetchBackgroundColor()
        background = color
        guard let data = try? JSONEncoder().encode(background) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    func fetchBackgroundColor() -> Color {
        guard let data = userDefaults.object(forKey: key) as? Data else { return Color(red: 1, green: 1, blue: 1) }
        guard let background = try? JSONDecoder().decode(Color.self, from: data) else { return Color(red: 1, green: 1, blue: 1) }
        return background
    }
}
