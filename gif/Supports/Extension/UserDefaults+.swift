//
//  UserDefaults+.swift
//  gif
//
//  Created by Duy Tran on 17/01/2023.
//

import Foundation

extension UserDefaults {
    static func saveUserData(userData: ProfileModel) {
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(userData)
            UserDefaults.standard.setValue(data, forKey: "ProfileModel")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }

    static func getInfor() -> ProfileModel? {
        var userData: ProfileModel
        if let data = UserDefaults.standard.data(forKey: "ProfileModel") {
            do {
                let decoder = JSONDecoder()
                userData = try decoder.decode(ProfileModel.self, from: data)
                return userData
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return nil
    }
    
    static func addPax(_ pax: ResponseListPax) {
        var data = getInfor()
        data?.listPax?.append(pax)
        saveUserData(userData: data!)
    }
    
    static func clearProfileModel(){
        UserDefaults.standard.removeObject(forKey: "ProfileModel")
    }
}
