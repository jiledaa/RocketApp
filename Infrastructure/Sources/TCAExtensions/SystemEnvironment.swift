//
//  SystemEnvironment.swift
//  RocketApp
//
//  Created by David Jilek on 08.09.2022.
//

import ComposableArchitecture
import Foundation

@dynamicMemberLookup
public struct SystemEnvironment<Environment> {
    var environment: Environment
    
    subscript<Dependency>(
        dynamicMember keyPath: WritableKeyPath<Environment, Dependency>
    ) -> Dependency {
        get { self.environment[keyPath: keyPath] }
        set { self.environment[keyPath: keyPath] = newValue }
    }

    var mainQueue: () -> AnySchedulerOf<DispatchQueue>
    var decoder: () -> JSONDecoder

    private static func decoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    public static func live(environment: Environment) -> Self {
        Self(environment: environment, mainQueue: { .main }, decoder: decoder)
    }

    public static func debug(environment: Environment) -> Self {
        Self(environment: environment, mainQueue: { .main }, decoder: decoder)
    }
}
