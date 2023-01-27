//
//  Rocket.swift
//  RocketApp
//
//  Created by David Jilek on 07.09.2022.
//

import ComposableArchitecture
import SwiftUI
import TCAExtensions

struct RocketView: View {
  var store: Store<RocketDetailState, RocketDetailAction>
  @ObservedObject var viewStore: ViewStore<RocketDetailState, RocketDetailAction>
  
  init(store: Store<RocketDetailState, RocketDetailAction>) {
    self.store = store
    viewStore = ViewStore(store)
  }
  
  var body: some View {
    VStack {
      
    }
  }
}

struct Rocket_Previews: PreviewProvider {
  static var previews: some View {
    RocketView(store: .init(
      initialState: RocketDetailState(),
      reducer: rocketDetailReducer,
      environment: RocketDetailEnvironment.debug(isFailing: false)
    ))
  }
}
