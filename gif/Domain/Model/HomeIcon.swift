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

    let ListIcon: [VNATabBarIconModel]
    let BgColor: Int
    let version: Int
}

struct item {
    let title: String
    let icon: String
    let action: Int
    
}

