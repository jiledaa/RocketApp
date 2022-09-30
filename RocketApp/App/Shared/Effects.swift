//
//  Effects.swift
//  RocketApp
//
//  Created by David Jilek on 08.09.2022.
//

import ComposableArchitecture
import Networking
import SwiftUI

func getDataEffect(decoder: JSONDecoder) -> Effect<RocketInfo, APIError> {
  guard let url = URL(string: "https://api.github.com/users/raywenderlich") else {
    fatalError("Error on creating url")
  }

  return URLSession.shared.dataTaskPublisher(for: url)
    .mapError { _ in APIError.downloadError }
    .map { data, _ in data }
    .decode(type: RocketInfo.self, decoder: decoder)
    .mapError { _ in APIError.decodingError }
    .eraseToEffect()
}

func mockDataEffect(decoder: JSONDecoder) -> Effect<[RocketInfo], APIError> {
  let dummyRockets = [
    RocketInfo(
        type: "Apollo 13",
        overView: "Apollo 13 is the timeless rocket, equipped by strong phase shields.",
        parameters: .init(height: "130m", diameter: "20m", mass: "150t"),
        firstStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons of fuel", burnTime: "162s"),
        secondStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons of fuel", burnTime: "162s"),
        photos: Data()
    ),
    RocketInfo(
        type: "Apollo 13",
        overView: "Apollo 13 is the timeless rocket, equipped by strong phase shields.",
        parameters: .init(height: "130m", diameter: "20m", mass: "150t"),
        firstStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons of fuel", burnTime: "162s"),
        secondStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons of fuel", burnTime: "162s"),
        photos: Data()
    ),
    RocketInfo(
        type: "Apollo 13",
        overView: "Apollo 13 is the timeless rocket, equipped by strong phase shields.",
        parameters: .init(height: "130m", diameter: "20m", mass: "150t"),
        firstStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons of fuel", burnTime: "162s"),
        secondStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons of fuel", burnTime: "162s"),
        photos: Data()
    )
  ]
  return Effect(value: dummyRockets)
}

func mockDataEffect(decoder: JSONDecoder) -> Effect<RocketInfo, APIError> {
  let dummyRocket =
    RocketInfo(
        type: "Apollo 13",
        overView: "Apollo 13 is the timeless rocket, equipped by strong phase shields.",
        parameters: .init(height: "130m", diameter: "20m", mass: "150t"),
        firstStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons of fuel", burnTime: "162s"),
        secondStage: .init(reusable: "reusable", engines: "9 engines", fuelMass: "350 tons of fuel", burnTime: "162s"),
        photos: Data()
    )
  return Effect(value: dummyRocket)
}
