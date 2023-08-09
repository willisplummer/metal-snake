//
//  snakeApp.swift
//  snake
//
//  Created by Willis Plummer on 8/8/23.
//

import SwiftUI

@main
struct snakeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(GameStateStore(initial: GameState(), reducer: gameReducer))
        }
    }
}
