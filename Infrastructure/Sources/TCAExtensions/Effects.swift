//
//  Effects.swift
//  RocketApp
//
//  Created by David Jilek on 08.09.2022.
//

import Networking
import ObjectModel
import ComposableArchitecture
import SwiftUI

public func getDataEffect(decoder: JSONDecoder) -> Effect<RocketInfo, APIError> {
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



