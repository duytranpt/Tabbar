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

struct listIcon: Codable {
    private enum CodingKeys: String, CodingKey {
        case Item
    }
    let Item: [item]
}

struct item: Codable {
    private enum CodingKeys: String, CodingKey {
        case title, icon, iconNotCircle, action
    }
    
    let title: String
    let icon: String
    let iconNotCircle: String
    let action: Int
}

