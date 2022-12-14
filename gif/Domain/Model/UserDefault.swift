//
//  UserDefault.swift
//  gif
//
//  Created by Duy Tran on 07/09/2022.
//

import Foundation

struct Defaults {
    
    static let userSessionKey = "HomeIcon"
    static let colorKey = "colorKey"
    static let listIcon = "listIcon"
    
    private static let userDefault = UserDefaults.standard
    
    static func set(list: HomeIcon) {
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(list)
            userDefault.setValue(data, forKey: userSessionKey)
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    static func get() -> HomeIcon? {
        
        var userData: HomeIcon
        if let data = userDefault.data(forKey: userSessionKey) {
            do {
                let decoder = JSONDecoder()
                userData = try decoder.decode(HomeIcon.self, from: data)
                return userData
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return nil
    }
    
    static func getColor() -> Int {
        return userDefault.integer(forKey: colorKey)
    }
    
    static func setColor(value: Int) {
        userDefault.set(value, forKey: colorKey)
    }
    
    static func set(listIT: [VNATabBarIconModel]) {
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(listIT)
            userDefault.setValue(data, forKey: listIcon)
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    static func getListIC() -> [VNATabBarIconModel]? {

        var userData: [VNATabBarIconModel]
        if let data = userDefault.data(forKey: listIcon) {
            do {
                let decoder = JSONDecoder()
                userData = try decoder.decode([VNATabBarIconModel].self, from: data)
                return userData
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return nil
    }

}
