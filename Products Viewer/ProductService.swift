import Foundation//
//  ProductService.swift
//  Products Viewer
//
//  Created by Alaa Magdy on 02/11/2026.
//

struct ProductService {
    private let feedURL = URL(string: "https://test.nweave.com/featured.txt")! //force upwrap it bec we know its a valid url
    
    func fetchProducts() async throws -> [Product] { //can throw errors and return list pf product objects
                                                //async so the app does not freeze
            let (data, response) = try await URLSession.shared.data(from: feedURL)
        
        guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)        //Checks that the response is valid and not nil.
                }
        
        // Temporary: tells us if the server's filter blocks the app with a 406.
        print("Status code: \(httpResponse.statusCode)")

        // A server error is not thrown by URLSession, so we check it ourselves.
        guard httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        // The feed is an array of wrappers, and we only want what's inside them.
        let wrappers = try JSONDecoder().decode([ProductWrapper].self, from: data)  //Converts JSON data into Swift objects.
        return wrappers.map { $0.product }
    }
}
