//
//  File.swift
//  
//
//  Created by David Jilek on 20.09.2022.
//

import ComposableArchitecture
import Foundation

public struct RocketDetail: Decodable, Identifiable, Equatable {
    public let id: Int
    public let type: String
    public let overview: String
    public let parameters: Parameters
    public let firstStage: Stage
    public let secondStage: Stage
    public let firstFlight: Date
    public let photos: Data

    public init(
        id: Int,
        type: String,
        overview: String,
        parameters: RocketDetail.Parameters,
        firstStage: RocketDetail.Stage,
        secondStage: RocketDetail.Stage,
        firstFlight: Date,
        photos: Data
    ) {
        self.id = id
        self.type = type
        self.overview = overview
        self.parameters = parameters
        self.firstStage = firstStage
        self.secondStage = secondStage
        self.firstFlight = firstFlight
        self.photos = photos
    }

    public struct Parameters: Decodable, Equatable {
        public let height: String
        public let diameter: String
        public let mass: String

        public init(height: String, diameter: String, mass: String) {
            self.height = height
            self.diameter = diameter
            self.mass = mass
        }
    }

    public struct Stage: Decodable, Equatable {
        public let reusable: String
        public let engines: String
        public let fuelMass: String
        public let burnTime: String

        public init(reusable: String, engines: String, fuelMass: String, burnTime: String) {
            self.reusable = reusable
            self.engines = engines
            self.fuelMass = fuelMass
            self.burnTime = burnTime
        }
    }
}

public extension RocketDetail {
    static let mock = Self(
        id: 1,
        type: "Apollo 13",
        overview: "Apollo 13 is the timeless rocket, equipped by strong phase shields.",
        parameters: .init(height: "130m", diameter: "20m", mass: "150t"),
        firstStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons", burnTime: "162s"),
        secondStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons", burnTime: "162s"),
        firstFlight: .init(),
        photos: Data()
    )

    enum CodingKeys: String, CodingKey {
        case id = "id",
             type = "type",
             overview = "overview",
             parameters = "parameters",
             firstStage = "first_stage",
             secondStage = "second_stage",
             firstFlight = "first_flight",
             photos = "photos"
    }
}
