//
//  TokenResponseModel.swift
//  AisleConnectTest
//
//  Created by 黃昌齊 on 2021/8/10.
//

import Foundation

struct TokenResponse: Codable {
    var access_token: String
    var token_type: String
    var refresh_token: String
    var expires_in: Int
    var scope: String
}
