import Foundation
import Networking
import ComposableArchitecture

struct RocketList: Decodable {
    let rocketData: [RocketInfo]
}

public struct RocketInfo: Decodable, Identifiable, Equatable {
    public let id: UUID
    public let type: String
    public let overView: String
    public let parameters: Parameters
    public let firstStage: Stage
    public let secondStage: Stage
    public let photos: Data

    public init(
        id: UUID = UUID(),
        type: String,
        overView: String,
        parameters: RocketInfo.Parameters,
        firstStage: RocketInfo.Stage,
        secondStage: RocketInfo.Stage,
        photos: Data
    ) {
        self.id = id
        self.type = type
        self.overView = overView
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

public extension RocketInfo {
    static func mockData(decoder: JSONDecoder) -> Effect<[RocketInfo], APIError> {
      let dummyRockets = [
        RocketInfo(
            type: "Apollo 13",
            overView: "Apollo 13 is the timeless rocket, equipped by strong phase shields.",
            parameters: .init(height: "130m", diameter: "20m", mass: "150t"),
            firstStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons", burnTime: "162s"),
            secondStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons", burnTime: "162s"),
            photos: Data()
        ),
        RocketInfo(
            type: "Apollo 13",
            overView: "Apollo 13 is the timeless rocket, equipped by strong phase shields.",
            parameters: .init(height: "130m", diameter: "20m", mass: "150t"),
            firstStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons", burnTime: "162s"),
            secondStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons", burnTime: "162s"),
            photos: Data()
        ),
        RocketInfo(
            type: "Apollo 13",
            overView: "Apollo 13 is the timeless rocket, equipped by strong phase shields.",
            parameters: .init(height: "130m", diameter: "20m", mass: "150t"),
            firstStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons", burnTime: "162s"),
            secondStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons", burnTime: "162s"),
            photos: Data()
        ),
      ]
      return Effect(value: dummyRockets)
    }

    static func mockData(decoder: JSONDecoder) -> Effect<RocketInfo, APIError> {
      let dummyRocket =
        RocketInfo(
            type: "Apollo 13",
            overView: "Apollo 13 is the timeless rocket, equipped by strong phase shields.",
            parameters: .init(height: "130m", diameter: "20m", mass: "150t"),
            firstStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons", burnTime: "162s"),
            secondStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons", burnTime: "162s"),
            photos: Data()
        )
      return Effect(value: dummyRocket)
    }
//    enum CodingKeys: String, CodingKey {
//        case type,
//            overview,
//            parameterHeight, parameterDiameter, parameterMass,
//            firstStageReusable, firstStageEngines, firstStageFuelMass, firstStageBurnTime,
//            secondStageReusable, secondStageEngines, secondStageFuelMass, secondStageBurnTime,
//            photos
//    }

//    static func getData(from url: String) async throws -> RocketInfo {
//        guard let url = URL(string: url) else {
//            throw APIError.badURL
//        }
//
//        let data = try await URLSession.shared.data(from: url)
//        return try JSONDecoder().decode(RocketInfo.self, from: data.0)
//    }
}
