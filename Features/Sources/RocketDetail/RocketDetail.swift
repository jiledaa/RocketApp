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

    init(meters: Float, feets: Float) {
      self.meters = meters
      self.feets = feets
    }
  }

  public struct WeightScale: Decodable {
    public let kilograms: Float
    public let pounds: Float

    init(kilograms: Float, pounds: Float) {
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
