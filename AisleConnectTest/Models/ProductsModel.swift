//
//  ProductsModel.swift
//  AisleConnectTest
//
//  Created by 黃昌齊 on 2021/8/10.
//

import Foundation

struct Product: Codable {
    var count: Int
    var data: Data
    
    struct Data: Codable {
        var id: Int
        var ean: Int
        var msrp: Int?
        var url: URL?
        var name: String
        var price: Double?
        var description: String?
        var imageUrl: URL?
    }
}
