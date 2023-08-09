//
//  GameScene.swift
//  snake
//
//  Created by Willis Plummer on 8/9/23.
//

import Foundation

struct GameScene {
  var store: GameStateStore
  var timeSinceLastTick: Float = 0
  
  init(store: GameStateStore) {
    self.store = store
  }
  
  mutating func update(deltaTime: Float) {
    let inputController = InputController.shared
    store.dispatch(.tick(deltaTime))
//    timeSinceLastTick += deltaTime * store.state.velocity

//    if timeSinceLastTick >= 1 {
//      store.dispatch(.tick)
//      timeSinceLastTick = 0
//    }

    if inputController.keysPressed.contains(.leftArrow) {
      store.dispatch(.changeDirection(.left))
    }
    if inputController.keysPressed.contains(.rightArrow) {
      store.dispatch(.changeDirection(.right))
    }
    if inputController.keysPressed.contains(.upArrow) {
      store.dispatch(.changeDirection(.up))
    }
    if inputController.keysPressed.contains(.downArrow) {
      store.dispatch(.changeDirection(.down))
    }
    if inputController.keysPressed.contains(.returnOrEnter) {
      store.dispatch(.restart)
    }
  }
}
