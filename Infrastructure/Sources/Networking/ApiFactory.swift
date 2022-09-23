//
//  File.swift
//  
//
//  Created by David Jilek on 23.09.2022.
//

import Foundation

public struct ApiFactory {
    public static func getData<T: Decodable>(from url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw APIError.badURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
