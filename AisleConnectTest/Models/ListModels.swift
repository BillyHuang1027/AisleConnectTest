//
//  ListModels.swift
//  AisleConnectTest
//
//  Created by 黃昌齊 on 2021/8/5.
//

import Foundation

struct List: Codable {
    let count: Int
    let data: [Data]
    let max: Int
    let message: String
    let processing: Int
    let status: Int
    let success: Bool
    let total: Int
}

struct Data: Codable {
    let id: Int
    let name: String
    let shared: Bool
    let created: String
    let lastModified: String
    let shopper: Shopper
    let products: [Products]?
    let `class`: String
    let statistics: Statistics
}

struct Shopper: Codable {
    let id: Int
    let nickname: String
}

struct Products: Codable {
    let id: Int
    let name: String
    let ean: Int
    let imageUrl: URL?
    let stores: [Stores]?
    let isbn10: String
    let isbn13: String
    let edition: String?
    let authors: [String]?
    let numPages: Int?
}

struct Stores: Codable {
    let id: Int
    let name: String
    let phone: String
    let owner: Owner
    let imageUrl: String
    let inStock: Int
    let price: Double?
    let currency: String
    let location: Location
}

struct Owner: Codable {
    let id: Int
}

struct Location: Codable {
    let id: Int
    let addressCity: String
    let addressCountry: String
    let addressLine1: String
    let addressState: String
    let addressZip: String
}

struct Statistics: Codable {
    let viewed: Int
    let followed: Int
}
