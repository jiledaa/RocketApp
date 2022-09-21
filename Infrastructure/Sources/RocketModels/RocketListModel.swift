import Foundation
import ComposableArchitecture

public struct RocketList: Decodable {
    public let rocketType: [String]
    public let firstFlight: [String]

    public init(rocketType: [String], firstFlight: [String]) {
        self.rocketType = rocketType
        self.firstFlight = firstFlight
    }
}

public struct RocketInfo: Decodable, Identifiable, Equatable {
    public let id: Int
    public let type: String
    public let overview: String
    public let parameters: Parameters
    public let firstStage: Stage
    public let secondStage: Stage
    public let photos: Data

    public init(
        id: Int,
        type: String,
        overview: String,
        parameters: RocketInfo.Parameters,
        firstStage: RocketInfo.Stage,
        secondStage: RocketInfo.Stage,
        photos: Data
    ) {
        self.id = id
        self.type = type
        self.overview = overview
        self.parameters = parameters
        self.firstStage = firstStage
        self.secondStage = secondStage
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

public extension RocketList {

    static func mockData(decoder: JSONDecoder) -> Effect<RocketList, APIError> {
      let dummyRockets = RocketList(
            rocketType: ["Apollo 13", "Falcon 1", "Voyager"],
            firstFlight: ["25.5.2020", "26.8.2021", "6.1.2022"]
        )

      return Effect(value: dummyRockets)
    }

    enum CodingKeys: String, CodingKey {
        case rocketType = "rocket_type", firstFlight = "first_flight"
    }
}

public extension RocketInfo {

    static func mockData(decoder: JSONDecoder) -> Effect<RocketInfo, APIError> {
      let dummyRocket =
        RocketInfo(
            id: 1,
            type: "Apollo 13",
            overview: "Apollo 13 is the timeless rocket, equipped by strong phase shields.",
            parameters: .init(height: "130m", diameter: "20m", mass: "150t"),
            firstStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons", burnTime: "162s"),
            secondStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons", burnTime: "162s"),
            photos: Data()
        )

      return Effect(value: dummyRocket)
    }

    enum CodingKeys: String, CodingKey {
        case id = "id",
            type = "type",
            overview = "overview",
            parameters = "parameters",
            firstStage = "first_stage",
            secondStage = "second_stage",
            photos = "photos"
    }
}
