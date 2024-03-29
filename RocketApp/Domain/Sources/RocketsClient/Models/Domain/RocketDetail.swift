import Foundation
import SwiftUI
import UIToolkit

public struct RocketDetail: Identifiable, Equatable {
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

  public struct LineMeasure: Equatable {
    public let meters: Float
    public let feet: Float

    init(meters: Float, feet: Float) {
      self.meters = meters
      self.feet = feet
    }
  }

  public struct WeightScale: Equatable {
    public let kilograms: Float
    public let pounds: Float

    init(kilograms: Float, pounds: Float) {
      self.kilograms = kilograms
      self.pounds = pounds
    }
  }

  public struct Stage: Equatable {
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
}

// swiftlint:disable identifier_name
public extension RocketDetail {
  enum RocketParameters {
    case id
    case name
    case overview
    case height
    case diameter
    case mass
    case fuel_mass
    case first_stage
    case second_stage
    case first_flight(String)
    case photos
    case reusable
    case not_reusable
    case engines(Int)
    case tons_of_fuel(Float)
    case seconds_burn_time(Int)

    public var name: LocalizedStringKey {
      switch self {
      case .overview:
        return .overview
      case .height:
        return .height
      case .diameter:
        return .diameter
      case .mass:
        return .mass
      case .first_stage:
        return .firstStage
      case .second_stage:
        return .secondStage
      case let .first_flight(date):
        return .firstFlight(date)
      case .photos:
        return .photos
      case .reusable:
        return .reusable
      case .not_reusable:
        return .notReusable
      case let .engines(count):
        return .engines(count)
      case let .tons_of_fuel(count):
        return .tonsOfFuelF(count)
      case let .seconds_burn_time(count):
        return .secondsBurnTime(count)
      default:
        return "Undefined"
      }
    }

    // TODO: Make custom formatter for RocketDetail
    public func detail(rocketDetail: RocketDetail, isUSMetrics: Bool) -> String {
      switch self {
      case .height:
        return isUSMetrics ? "\(rocketDetail.height.feet)" + "ft" : "\(rocketDetail.height.meters)" + "m"
      case .diameter:
        return isUSMetrics ? "\(rocketDetail.diameter.feet)" + "ft" : "\(rocketDetail.diameter.meters)" + "m"
      case .mass:
        return isUSMetrics ? "\(rocketDetail.mass.pounds)" + "℔" : "\(rocketDetail.mass.kilograms)" + "kg"
      default:
        return "Undefined"
      }
    }
  }
}
