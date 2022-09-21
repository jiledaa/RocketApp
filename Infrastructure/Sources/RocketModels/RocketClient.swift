//
//  RocketClient.swift
//  
//
//  Created by David Jilek on 20.09.2022.
//

import Foundation
import RocketModels
import ComposableArchitecture

struct RocketClient {
    var rocketList: @Sendable (RocketListModel) async throws -> RocketListModel

    static func get<T: Decodable>(from url: String) async throws -> [T] {
        guard let url = URL(string: url) else {
            throw APIError.badURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([T].self, from: data)
    }
}
