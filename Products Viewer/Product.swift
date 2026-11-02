//  Product.swift
//  Products Viewer
//
//  Created by Alaa Magdy on 02/11/2026.
//

import Foundation

struct ProductWrapper: Decodable {
    let product: Product

    enum CodingKeys: String, CodingKey {
        case product = "Product"
    }
}

struct Product: Decodable {
    let id: String
    let name: String
    let description: String
    let price: String
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case imageUrl = "image_url"
    }
}
