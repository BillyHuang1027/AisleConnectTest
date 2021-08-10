//
//  ConnectController.swift
//  AisleConnectTest
//
//  Created by 黃昌齊 on 2021/8/5.
//

import Foundation
import UIKit

class ConnectController {
    static let shared = ConnectController()
    
    func retrieveToken(username: String, password: String, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = URL(string: "https://apistage2.aisleconnect.us/ac.server/oauth/token")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        var urlComponents = URLComponents()
        urlComponents.queryItems = [
            URLQueryItem(name: "grant_type", value: "password"),
            URLQueryItem(name: "username", value: username),
            URLQueryItem(name: "password", value: password),
            URLQueryItem(name: "client_id", value: "my-client"),
            URLQueryItem(name: "client_secret", value: "my-secret"),
            URLQueryItem(name: "scope", value: "read")
        ]
        request.httpBody = urlComponents.query?.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let tokenResponse = try! decoder.decode(TokenResponse.self, from: data)
                    print(tokenResponse)
                    completion(.success(tokenResponse))
                } catch {
                    completion(.failure(error))
                    print(error)
                }
            }
        } .resume()
    }
    
    func fetchBookListData(urlStr: String, completion: @escaping (Result<List, Error>) -> Void) {
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let bookListResponse = try decoder.decode(List.self, from: data)
                    print("List Response", bookListResponse)
                    completion(.success(bookListResponse))
                } catch {
                    completion(.failure(error))
                    print(error)
                }
            } else if let error = error {
                completion(.failure(error))
                print(error)
            }
        } .resume()
    }
    
    func fetchListDetailData(urlStr: String, completion: @escaping (Result<ListDetail, Error>) -> Void) {
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let bookListResponse = try decoder.decode(ListDetail.self, from: data)
                    print("Detail Response", bookListResponse)
                    completion(.success(bookListResponse))
                } catch {
                    completion(.failure(error))
                    print(error)
                }
            } else if let error = error {
                completion(.failure(error))
                print(error)
            }
        } .resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
               let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        } .resume()
    }
    
    func fetchProductsData(urlStr: String, completion: @escaping (Result<Product, Error>) -> Void) {
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let productsResponse = try decoder.decode(Product.self, from: data)
                    print("Product Response", productsResponse)
                    completion(.success(productsResponse))
                } catch {
                    completion(.failure(error))
                    print(error)
                }
            } else if let error = error {
                completion(.failure(error))
                print(error)
            }
        } .resume()
    }
}


