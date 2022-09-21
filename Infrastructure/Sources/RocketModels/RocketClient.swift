//
//  RocketClient.swift
//  
//
//  Created by David Jilek on 20.09.2022.
//

import Foundation
import Networking
import ComposableArchitecture

enum ViewType {
    case rocketList, rocketDetail

    var rocketModel: Any {
        switch self {
        case .rocketList:
            return RocketListModel.self
        case .rocketDetail:
            return RocketDetailModel.self
        }
    }
}

public struct RocketClient {
    var rocketList: @Sendable (RocketListModel) async throws -> RocketListModel
    var rocketDetail: @Sendable (RocketDetailModel) async throws -> RocketDetailModel

    public init(
        rocketList: @escaping @Sendable (RocketListModel) async throws -> RocketListModel,
        rocketDetail: @escaping @Sendable (RocketDetailModel) async throws -> RocketDetailModel
    ) {
        self.rocketList = rocketList
        self.rocketDetail = rocketDetail
    }

    static func getData<T: Decodable>(from url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw APIError.badURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

public extension RocketClient {

    static let live = RocketClient(
        rocketList: { _ in
            try await getData(from: URLs.SpaceRockets.allRockets)
        },
        rocketDetail: { _ in
            try await getData(from: URLs.SpaceRockets.oneRocket(id: ""))
        }
    )
}
