//
//  Model.swift
//  gif
//
//  Created by Duy Tran on 15/12/2022.
//

import Foundation

struct Root : Decodable {
    let Arr: [HomeMyProfileItem]
}

struct HomeMyProfileItem: Decodable {
    let HomeItem : [HomeItem]
    let Title: String
}

struct HomeItem: Decodable {
    let title, action, icon, des: String
}
