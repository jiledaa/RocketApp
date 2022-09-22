//
//  File.swift
//
//
//  Created by David Jilek on 20.09.2022.
//

import ComposableArchitecture
import Foundation
import Networking

public struct RocketListModel: Decodable {
    public let rocketType: [String]
    public let firstFlight: [String]

    public init(rocketType: [String], firstFlight: [String]) {
        self.rocketType = rocketType
        self.firstFlight = firstFlight
    }
}

public extension RocketListModel {

    static let mockData = Self(
        rocketType: ["Apollo 13", "Falcon 1", "Voyager"],
        firstFlight: ["25.5.2020", "26.8.2021", "6.1.2022"]
    )

    enum CodingKeys: String, CodingKey {
        case rocketType = "rocket_type", firstFlight = "first_flight"
    }
}
