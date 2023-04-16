#if DEBUG
import Dependencies

public extension RocketConverter {
  static let test = Self(
    externalModelConverter: unimplemented("\(Self.self).externalModelConverter"),
    domainModelConverter: unimplemented("\(Self.self).domainModelConverter")
  )
}

public extension RocketsConverter {
  static let test = Self(
    externalModelConverter: unimplemented("\(Self.self).externalModelConverter"),
    domainModelConverter: unimplemented("\(Self.self).domainModelConverter")
  )
}
#endif
