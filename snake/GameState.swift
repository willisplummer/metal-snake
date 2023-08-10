//
//  GameState.swift
//  snake
//
//  Created by Willis Plummer on 8/8/23.
//

import Foundation

enum Direction {
  case left, right, up, down

  func vector() -> float2 {
    switch self {
    case .up:
      return float2(0,1)
    case .down:
      return float2(0, -1)
    case .left:
      return float2(-1, 0)
    case .right:
      return float2(1, 0)
    }
  }

  func isValidDirectionChange(newDir: Direction) -> Bool {
    switch self {
    case .up:
      return [.left, .right].contains(newDir)
    case .down:
      return [.left, .right].contains(newDir)
    case .left:
      return [.up, .down].contains(newDir)
    case .right:
      return [.up, .down].contains(newDir)
    }
  }

}

enum GameAction {
  case changeDirection(Direction)
  case tick(Float)
  case restart
}

struct GameState {
  var direction: Direction
  var newDirection: Direction
  var velocity: Float
  var score: Int32
  var position: [float2]
  var applePosition: float2
  var gameOver: Bool
  var timeSinceLastMove: Float

  init() {
    let initialSnakePosition = [float2(0,0), float2(0, -1), float2(0,-2)]
//    TODO: why does it cause the flicker if i generate this
    let initialApplePosition = getNewApplePosition(snakePosition: initialSnakePosition)

    direction = .up
    newDirection = .up
    velocity = 4
    position = initialSnakePosition
    applePosition = initialApplePosition
    gameOver = false
    score = 0
    timeSinceLastMove = 0
  }
}

func gameReducer(state: GameState, action: GameAction) -> GameState {
  var newState = state
  switch action {
  case .restart:
    newState = GameState()
    return newState
    
  case .changeDirection(let dir):
    if state.direction.isValidDirectionChange(newDir: dir) {
      newState.newDirection = dir
    }
  case .tick(let deltaTime):
    if state.gameOver == true {
      return state
    }

    newState.timeSinceLastMove += deltaTime * newState.velocity
    if newState.timeSinceLastMove < 1 {
      return newState
    }
    newState.timeSinceLastMove = 0

    newState.direction = newState.newDirection
    let newHead = makeNewHead(newState.position[0], direction: newState.direction)
    if newState.position.contains(newHead) {
      newState.gameOver = true
    }

    newState.position.insert(newHead, at: 0)

    if newHead == newState.applePosition {
      newState.applePosition = getNewApplePosition(snakePosition: newState.position)
      newState.velocity += 1
      newState.score += 1
    } else {
      newState.position.removeLast()
    }
  }
  return newState
}

func makeNewHead(_ oldHeadPosition: float2, direction: Direction) -> float2 {
  var newPos = oldHeadPosition + direction.vector()
//  TODO: pull out 10 into a const
//  TODO: refactorwhe
//  TODO: why is this weird re 9 and 10
  if newPos.x > 9 {
    newPos.x = -10
  }
  if newPos.x < -10 {
    newPos.x = 9
  }
  if newPos.y > 9 {
    newPos.y = -10
  }
  if newPos.y < -10 {
    newPos.y = 9
  }
  
  return newPos
}

func getNewApplePosition(snakePosition: [float2]) -> float2 {
  let x: Float = floor(Float.random(in: -10 ... 9))
  let y: Float = floor(Float.random(in: -10 ... 9))
  let target = float2(x, y)

  if (!snakePosition.contains(target)) {
    return target
  }

  return getNewApplePosition(snakePosition: snakePosition)
}
