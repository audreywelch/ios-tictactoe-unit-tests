//
//  GameBoard.swift
//  TicTacToe
//
//  Created by Andrew R Madsen on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

enum GameBoardError: Error, Equatable {
    case invalidSquare
}

typealias Coordinate = (x: Int, y: Int)

struct GameBoard {
    
    enum Mark: Equatable {
        case x
        case o
        
        var stringValue: String {
            switch self {
            case .x: return "X"
            case .o: return "O"
            }
        }
    }
    
    private enum Square: Equatable {
        case filled(Mark)
        case empty
    }
    
    subscript(coordinate: Coordinate) -> Mark? {
        let square = squares[arrayIndex(for: coordinate)]
        if case let Square.filled(mark) = square {
            return mark
        } else {
            return nil
        }
    }
    
    // place a mark at position
    mutating func place(mark: Mark, on square: Coordinate) throws {
        if self[square] != nil {
            throw GameBoardError.invalidSquare
        }
        squares[arrayIndex(for: square)] = .filled(mark)
    }
    
    // board is full
    var isFull: Bool {
        for square in squares {
            if square == .empty {
                return false
            }
        }
        return true
    }
    
    // board is valid
    var isValid: Bool {
        
        // Scenarios to test
            // Cannot be more than 5 x's
            // Cannot be more than 4 o's
            // The number of x's must equal the number of o's
            // the number of x's must be 1 more than the number of o's
        
        if numberOfXs > 5 { return false }
        if numberOfOs > 4 { return false }
        
        if numberOfXs == numberOfOs || numberOfXs == (numberOfOs + 1) {
            return true
        }
        return false
    }
    
    var numberOfXs: Int {
        return countOf(mark: .x)
    }
    
    var numberOfOs: Int {
        return countOf(mark: .o)
    }
    
    private func arrayIndex(for square: Coordinate) -> Int {
        return square.y * 3 + square.x
    }
    
    private func countOf(mark: GameBoard.Mark) -> Int {
        var count = 0
        for x in 0 ..< 3 {
            for y in 0 ..< 3 {
                if self[(x: x, y: y)] == mark {
                    count += 1
                }
            }
        }
        return count
    }
    
    private var squares = Array(repeating: Square.empty, count: 9)
}
