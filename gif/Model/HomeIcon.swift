//
//  Student.swift
//  gif
//
//  Created by Duy Tran on 24/08/2022.
//

import Foundation

struct HomeIcon: Codable {
    private enum CodingKeys: String, CodingKey {
        case ListIcon, BgColor, version
    }

    let ListIcon: [item]
    let BgColor: Int
    let version: Int
}

struct item: Codable {
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

