//
//  GameAI.swift
//  TicTacToe
//
//  Created by Andrew R Madsen on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

func game(board: GameBoard, isWonBy player: GameBoard.Mark) -> Bool {
    
    // only return true if board is also valid
    guard board.isValid else { return false }
    
    // If it's 'player x', in order to win the number of x's need to be one more than 'player o' b/c 'x' goes first
    if player == .x {
        guard board.numberOfXs == board.numberOfOs + 1 else { return false }
    }
    
    // If it's 'player o', in order to win the number of o's need to be the same as the number of x's
    if player == .o {
        guard board.numberOfOs == board.numberOfXs else { return false }
    }
    
    // Check if player won horizontally
    for y in 0 ..< 3 {
        let p1 = board[(x: 0, y: y)]
        let p2 = board[(x: 1, y: y)]
        let p3 = board[(x: 2, y: y)]
        if p1 == player && p2 == player && p3 == player {
            return true
        }
    }
    
    // Check if player won vertically
    for x in 0 ..< 3 {
        let p1 = board[(x: x, y: 0)]
        let p2 = board[(x: x, y: 1)]
        let p3 = board[(x: x, y: 2)]
        if p1 == player && p2 == player && p3 == player {
            return true
        }
    }
    
    // Check if player won diagonally (top left -> bottom right)
    if board[(x: 0, y: 0)] == player && board[(x: 1, y: 1)] == player && board[(x: 2, y:2)] == player {
        return true
    }
    
    // Check if player won diagonally (top right -> bottom left)
    if board[(x: 2, y: 0)] == player && board[(x: 1, y: 1)] == player && board[(x: 0, y:2)] == player {
        return true
    }
    
    return false
}
