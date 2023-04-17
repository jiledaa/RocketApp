import Foundation
import ModelConvertible

public typealias RocketConverter = ModelConverter<RocketDetail, RocketDetailDTO>
public typealias RocketsConverter = ModelConverter<[RocketDetail], [RocketDetailDTO]>

public typealias LineMeasureConverter = ModelConverter<RocketDetail.LineMeasure, RocketDetailDTO.LineMeasure>
public typealias WeightScaleConverter = ModelConverter<RocketDetail.WeightScale, RocketDetailDTO.WeightScale>
public typealias StageConverter = ModelConverter<RocketDetail.Stage, RocketDetailDTO.Stage>
