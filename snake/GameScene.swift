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
      inputController.keysPressed.remove(.leftArrow)
    }
    if inputController.keysPressed.contains(.rightArrow) {
      store.dispatch(.changeDirection(.right))
      inputController.keysPressed.remove(.rightArrow)
    }
    if inputController.keysPressed.contains(.upArrow) {
      store.dispatch(.changeDirection(.up))
      inputController.keysPressed.remove(.upArrow)
    }
    if inputController.keysPressed.contains(.downArrow) {
      store.dispatch(.changeDirection(.down))
      inputController.keysPressed.remove(.rightArrow)
    }
    if inputController.keysPressed.contains(.returnOrEnter) {
      store.dispatch(.restart)
      inputController.keysPressed.remove(.returnOrEnter)
    }
  }
}
