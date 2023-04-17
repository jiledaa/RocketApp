import Dependencies
import Foundation
import ModelConvertible

public extension RocketConverter {
  static var live: Self {
    @Dependency(\.lineMeasureConverter) var lineMeasureConverter
    @Dependency(\.weightScaleConverter) var weightScaleConverter
    @Dependency(\.stageConverter) var stageConverter

    return .init(
      domainModelConverter: { rocketDTO in
        guard
          let height = lineMeasureConverter.domainModel(fromExternal: rocketDTO.height),
          let diameter = lineMeasureConverter.domainModel(fromExternal: rocketDTO.diameter),
          let mass = weightScaleConverter.domainModel(fromExternal: rocketDTO.mass),
          let firstStage = stageConverter.domainModel(fromExternal: rocketDTO.firstStage),
          let secondStage = stageConverter.domainModel(fromExternal: rocketDTO.secondStage)
        else {
          return RocketDetail.mock
        }

        return RocketDetail(
          id: rocketDTO.id,
          name: rocketDTO.name,
          overview: rocketDTO.overview,
          height: height,
          diameter: diameter,
          mass: mass,
          firstStage: firstStage,
          secondStage: secondStage,
          firstFlight: rocketDTO.firstFlight,
          photos: rocketDTO.photos
        )
      }
    )
  }
}

public extension RocketsConverter {
  static var live: Self {
    @Dependency(\.lineMeasureConverter) var lineMeasureConverter
    @Dependency(\.weightScaleConverter) var weightScaleConverter
    @Dependency(\.stageConverter) var stageConverter

    return .init(
      domainModelConverter: { rocketsDTO in
        rocketsDTO.map {
          guard
            let height = lineMeasureConverter.domainModel(fromExternal: $0.height),
            let diameter = lineMeasureConverter.domainModel(fromExternal: $0.diameter),
            let mass = weightScaleConverter.domainModel(fromExternal: $0.mass),
            let firstStage = stageConverter.domainModel(fromExternal: $0.firstStage),
            let secondStage = stageConverter.domainModel(fromExternal: $0.secondStage)
          else {
            return RocketDetail.mock
          }

          return RocketDetail(
            id: $0.id,
            name: $0.name,
            overview: $0.overview,
            height: height,
            diameter: diameter,
            mass: mass,
            firstStage: firstStage,
            secondStage: secondStage,
            firstFlight: $0.firstFlight,
            photos: $0.photos
          )
        }
      }
    )
  }
}

public extension LineMeasureConverter {
  static var live = Self(
    domainModelConverter: {
      RocketDetail.LineMeasure(meters: $0.meters, feet: $0.feet)
    }
  )
}

public extension WeightScaleConverter {
  static var live = Self(
    domainModelConverter: {
      RocketDetail.WeightScale(kilograms: $0.kilograms, pounds: $0.pounds)
    }
  )
}

public extension StageConverter {
  static var live = Self(
    domainModelConverter: {
      RocketDetail.Stage(reusable: $0.reusable, engines: $0.engines, fuelMass: $0.fuelMass, burnTime: $0.burnTime)
    }
  )
}
