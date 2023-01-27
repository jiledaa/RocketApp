//
//  ApiError.swift
//  RocketApp
//
//  Created by David Jilek on 08.09.2022.
//
import Foundation

public enum APIError: Error {
  case badURL
  case downloadError
  case decodingError
}
