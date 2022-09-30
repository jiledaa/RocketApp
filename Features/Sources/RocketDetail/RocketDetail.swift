//
//  File.swift
//  
//
//  Created by David Jilek on 20.09.2022.
//

import ComposableArchitecture
import Foundation

public struct RocketDetail: Decodable, Identifiable, Equatable {
    public let id: String
    public let name: String
    public let overview: String
    public let height: LineMeasure
    public let diameter: LineMeasure
    public let mass: WeightScale
    public let firstStage: Stage
    public let secondStage: Stage
    public let firstFlight: String
    public let photos: [String]

    public init(
        id: String,
        name: String,
        overview: String,
        height: LineMeasure,
        diameter: LineMeasure,
        mass: WeightScale,
        firstStage: RocketDetail.Stage,
        secondStage: RocketDetail.Stage,
        firstFlight: String,
        photos: [String]
    ) {
        self.id = id
        self.name = name
        self.overview = overview
        self.height = height
        self.diameter = diameter
        self.mass = mass
        self.firstStage = firstStage
        self.secondStage = secondStage
        self.firstFlight = firstFlight
        self.photos = photos
    }

    public struct LineMeasure: Decodable {
        public let meters: Float
        public let feets: Float

        internal init(meters: Float, feets: Float) {
            self.meters = meters
            self.feets = feets
        }
    }

    public struct WeightScale: Decodable {
        public let kilograms: Float
        public let pounds: Float

        internal init(kilograms: Float, pounds: Float) {
            self.kilograms = kilograms
            self.pounds = pounds
        }
    }

    public struct Stage: Decodable, Equatable {
        public let reusable: Bool
        public let engines: Int
        public let fuelMass: Float
        public let burnTime: Int?

        public init(reusable: Bool, engines: Int, fuelMass: Float, burnTime: Int?) {
            self.reusable = reusable
            self.engines = engines
            self.fuelMass = fuelMass
            self.burnTime = burnTime
        }
    }

    public static func == (lhs: RocketDetail, rhs: RocketDetail) -> Bool {
        lhs.name < rhs.name
    }
}

public extension RocketDetail {
    static let mock = Self(
        id: "apollo13",
        name: "Apollo 13",
        overview: "Apollo 13 is the timeless rocket, equipped by strong phase shields.",
        height: .init(meters: 130, feets: 426.4),
        diameter: .init(meters: 20.2, feets: 66.26),
        mass: .init(kilograms: 150, pounds: 330.7),
        firstStage: .init(reusable: true, engines: 9, fuelMass: 350, burnTime: 162),
        secondStage: .init(reusable: true, engines: 9, fuelMass: 350, burnTime: 162),
        firstFlight: "1991-03-09",
        photos: ["https://imgur.com/DaCfMsj.jpg", "https://imgur.com/azYafd8.jpg"]
    )

    enum CodingKeys: String, CodingKey {
        case id = "rocket_id"
        case name = "rocket_name"
        case overview = "description"
        case height
        case diameter
        case mass
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case firstFlight = "first_flight"
        case photos = "flickr_images"
    }
}

public extension RocketDetail.LineMeasure {
    enum CodingKeys: String, CodingKey {
        case meters
        case feets = "feet"
    }
}

public extension RocketDetail.WeightScale {
    enum CodingKeys: String, CodingKey {
        case kilograms = "kg"
        case pounds = "lb"
    }
}

extension RocketDetail.Stage {
    enum CodingKeys: String, CodingKey {
        case reusable
        case engines
        case fuelMass = "fuel_amount_tons"
        case burnTime = "burn_time_sec"
    }
}
