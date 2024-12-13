//
//  PlaceModel.swift
//  NearbyApp NLW
//
//  Created by Emanuel on 10/12/2024.
//

import Foundation

struct Place: Decodable {
    let id: String
    let name: String
    let description: String
    let coupons: Int
    let latitude: Double
    let longitude: Double
    let address: String
    let phone: String
    let cover: String
    let categoryId: String
}
