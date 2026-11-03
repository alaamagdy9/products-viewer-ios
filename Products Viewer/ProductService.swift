//
//  ProductService.swift
//  Products Viewer
//
//  Created by Alaa Magdy on 02/11/2026.
//

import Foundation

struct ProductService {
    private let feedURL = URL(string: "https://test.nweave.com/featured.txt")! //force unwrap it bec we know its a valid url
    
    func fetchProducts() async throws -> [Product] { //can throw errors and return list of product objects
                                                //async so the app does not freeze
            let (data, response) = try await URLSession.shared.data(from: feedURL)    //get request  to the server and wait for the response
        //and await for the asynchronus work
        
        guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)        // check Only an HTTP response has a status code.
                }

        // did it return 200
        guard httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        // The feed is an array of wrappers, and we only want what's inside them.
        let wrappers = try JSONDecoder().decode([ProductWrapper].self, from: data)  //Converts JSON data into Swift objects.
        return wrappers.map { $0.product }
    }
}
