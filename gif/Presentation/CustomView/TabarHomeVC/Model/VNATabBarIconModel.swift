//
//  Icon.swift
//  gif
//
//  Created by Duy Tran on 31/08/2022.
//

import Foundation

struct VNATabBarIconModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case title, icon, iconHightLight, iconNotCircle, iconHightLightNotCircle, action
    }
    
    let title: String
    let icon: String
    let iconHightLight: String
    let iconNotCircle: String
    let iconHightLightNotCircle: String
    let action: Int
}
