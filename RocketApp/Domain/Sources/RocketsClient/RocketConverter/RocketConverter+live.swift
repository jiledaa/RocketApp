import Foundation
import ModelConvertible

public typealias RocketConverter = ModelConverter<RocketDetail, RocketDetailDTO>

public extension RocketConverter {
  static var live: Self {
    .init(
      externalModelConverter: { rockets in
        guard let rocketDetailDTO = Self.live.externalModel(fromDomain: rockets) else {
          return nil
        }

        return rocketDetailDTO
      },

      domainModelConverter: { rocketsDTO in
        guard let rocketDetail = Self.live.domainModel(fromExternal: rocketsDTO) else {
          return nil
        }

        return rocketDetail
      }
    )
  }
}

public typealias RocketsConverter = ModelConverter<[RocketDetail], [RocketDetailDTO]>

public extension RocketsConverter {
  static var live: Self {
    .init(
      externalModelConverter: { rockets in
        guard let rocketDetailDTO = Self.live.externalModel(fromDomain: rockets) else {
          return nil
        }

        return rocketDetailDTO
      },

      domainModelConverter: { rocketsDTO in
        guard let rocketDetail = Self.live.domainModel(fromExternal: rocketsDTO) else {
          return nil
        }

        return rocketDetail
      }
    )
  }
}
