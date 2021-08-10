//
//  ListDetailModels.swift
//  AisleConnectTest
//
//  Created by 黃昌齊 on 2021/8/6.
//

import Foundation

struct ListDetail: Codable {
    let count: Int
    let data: Data
    let max: Int
    let message: String
    let processing: Int
    let status: Int
    let success: Bool
    let total: Int
}
