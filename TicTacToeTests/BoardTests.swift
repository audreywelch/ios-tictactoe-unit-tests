
// Write tests to figure out if tic tac toe logic is working

import XCTest
// I need to tell my tests about my app b/c we need to access some of the functions
// @testable means we can access things in TicTacToe that are not public, just internal - but it will not expose private functions
@testable import TicTacToe

class BoardTests: XCTestCase {

/*
     Scenarios in tic-tac-toe
        1. win horizontally
        2. win vertically
        3. win diagonally
        4. tie game (no winner)
        5. board is empty
 */

    // Need to test that the board is valid, meaning the number of x's is either equal to number of o's or it has one more - you cannot play the game without alternating turns
    
    func testHorizontalWin() throws {
        
        var board = GameBoard()
        
        // Win across the top
        try board.place(mark: .x, on: (x: 0, y: 0))
        try board.place(mark: .x, on: (x: 1, y: 0))
        try board.place(mark: .x, on: (x: 2, y: 0))
        
        try board.place(mark: .o, on: (x: 0, y: 1))
        try board.place(mark: .o, on: (x: 1, y: 1))
        
        XCTAssert(board.isValid, "This is an impossible board")
        XCTAssert(board.numberOfXs == board.numberOfOs + 1)
        
        let isWonByX = game(board: board, isWonBy: .x)
        // I want this condition to be true, if it's not true, then it fails
        XCTAssertTrue(isWonByX, "X should be declared the winner")
        
        let isWonByO = game(board: board, isWonBy: .o)
        // I want this condition to be false, if it's not false, then it fails
        XCTAssertFalse(isWonByO, "O should be the loser")
        XCTAssert(isWonByX != isWonByO, "There can be only one winner")
    }
    
    func testVerticalWin() throws {
        var board = GameBoard()
        try board.place(mark: .x, on: (x: 0, y: 0))
        try board.place(mark: .x, on: (x: 0, y: 1))
        try board.place(mark: .x, on: (x: 0, y: 2))
        
        try board.place(mark: .o, on: (x: 1, y: 0))
        try board.place(mark: .o, on: (x: 1, y: 1))
        
        let isWonByX = game(board: board, isWonBy: .x)
        // I want this condition to be true, if it's not true, then it fails
        XCTAssertTrue(isWonByX, "X should be declared the winner")
        
        let isWonByO = game(board: board, isWonBy: .o)
        // I want this condition to be false, if it's not false, then it fails
        XCTAssertFalse(isWonByO, "O should be the loser")
        XCTAssert(isWonByX != isWonByO, "There can be only one winner")
    }
    
    func testDiagonalWin() throws {
        var board = GameBoard()
        try board.place(mark: .x, on: (x: 0, y: 0))
        try board.place(mark: .x, on: (x: 1, y: 1))
        try board.place(mark: .x, on: (x: 2, y: 2))
        
        try board.place(mark: .o, on: (x: 1, y: 0))
        try board.place(mark: .o, on: (x: 0, y: 1))
        
        let isWonByX = game(board: board, isWonBy: .x)
        // I want this condition to be true, if it's not true, then it fails
        XCTAssertTrue(isWonByX, "X should be declared the winner")
        
        let isWonByO = game(board: board, isWonBy: .o)
        // I want this condition to be false, if it's not false, then it fails
        XCTAssertFalse(isWonByO, "O should be the loser")
        XCTAssert(isWonByX != isWonByO, "There can be only one winner")
    }
    func testTieGame() throws {
        
        var board = GameBoard()
        
        // One scenario of a tie game
        try board.place(mark: .x, on: (x: 0, y: 0))
        try board.place(mark: .o, on: (x: 1, y: 0))
        try board.place(mark: .x, on: (x: 2, y: 0))
        try board.place(mark: .x, on: (x: 0, y: 1))
        try board.place(mark: .o, on: (x: 1, y: 1))
        try board.place(mark: .x, on: (x: 2, y: 1))
        try board.place(mark: .o, on: (x: 0, y: 2))
        try board.place(mark: .x, on: (x: 1, y: 2))
        try board.place(mark: .o, on: (x: 2, y: 2))
        
        // in order for a tie to be true, we need to assert that the board is full and also that it was not won by x and not won by 0
        XCTAssertTrue(board.isFull, "Tie games only occur with a full board")
        
        let isWonByX = game(board: board, isWonBy: .x)
        XCTAssertFalse(isWonByX, "Tie games cannot have a winner")
        let isWonByO = game(board: board, isWonBy: .o)
        XCTAssertFalse(isWonByO, "Tie games cannot have a winner")
    }
    
    func testEmptyBoard() {
        let empty = GameBoard()
        for x in 0 ..< 3 {
            for y in 0 ..< 3 {
                let mark = empty[(x: x, y: y)]
                XCTAssertNil(mark, "Position (\(x), \(y)) should be empty")
            }
        }
    }
    
    
}
