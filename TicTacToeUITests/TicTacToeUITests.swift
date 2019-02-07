

import XCTest
// @testable import TicTacToe
// ^ don't want this b/c not interested in testing the logic of the app, I'm interested in the UI of the app, want to test what's on screen

enum Mark {
    case x
    case o
    case empty
    
    var stringValue: String {
        switch self {
        case .x: return "X"
        case.o: return "O"
        case .empty: return " "
        }
    }
}

enum StatusTexts {
    case turn(Mark)
    case win(Mark)
    case tie
    
    var stringValue: String {
        switch self {
        case .turn(let mark): return "Player \(mark.stringValue)'s turn"
        case .win(let mark): return "Player \(mark.stringValue) won!"
        case .tie: return "Cat's game!"
        }
    }
}

class TicTacToeUITests: XCTestCase {

    var app: XCUIApplication!
    
    var statusLabel: XCUIElement {
        return app.staticTexts["GameViewController.statusLabel"]
    }
    
    var restartButton: XCUIElement {
        return app.buttons["GameViewController.restartButton"]
    }
    
    func button(at index: Int) -> XCUIElement {
        let identifier = "BoardViewController.tile\(index)"
        return app.buttons[identifier]
    }
    
    override func setUp() {

        // In UI tests it is usually best to stop immediately when a failure occurs.
        // Specify that if we encounter a failure, we want to stop right away
        continueAfterFailure = false

        // Grab the app
        app = XCUIApplication()
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        // Instruct application to launch for every test.
        
        if app.state == .notRunning {
            app.launch()
        } else if app.state != .runningForeground {
            app.activate()
        }

        // Need to reset everything to intial state
        restartButton.tap()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: element existence
    
    func testInitialState() {
        
        // Verify that I can find the label
        XCTAssertTrue(statusLabel.exists)
        XCTAssertEqual(statusLabel.label, StatusTexts.turn(.x).stringValue)
        
        XCTAssertTrue(restartButton.exists)
        XCTAssertEqual(restartButton.label, "Restart")
        
        // Verify that nine buttons are blank
        for buttonNumber in 0 ..< 9 {
            let button = self.button(at: buttonNumber)
            XCTAssertTrue(button.exists)
            XCTAssertEqual(button.label, " ")
        }
    }
    
    // MARK: element interaction
    
    /*
    possible interactions
     - tap on the 9 tiles
     - tap on the restart button
     
     */
    
    // Helper function
    func tapButton(_ number: Int, player: Mark? = nil, expecting mark: Mark, file: StaticString = #file, line: UInt = #line) {
        
        // test the label has the right value *before* the test
        let playerMark = player ?? mark
        
        let status = StatusTexts.turn(playerMark)
        XCTAssertEqual(statusLabel.label, status.stringValue, file: file, line: line)
        
        let button = self.button(at: number)
        button.tap()
        XCTAssertEqual(button.label, mark.stringValue, file: file, line: line)
    }
    
    func testTileTaps() {
        
        // test for
        //  XOX
        //  XOX
       //   OXO
        
        tapButton(0, expecting: .x)
        tapButton(1, expecting: .o)
        tapButton(2, expecting: .x)
        tapButton(4, expecting: .o)
        tapButton(3, expecting: .x)
        tapButton(6, expecting: .o)
        tapButton(5, expecting: .x)
        tapButton(8, expecting: .o)
        tapButton(7, expecting: .x)
        
        XCTAssertEqual(statusLabel.label, StatusTexts.tie.stringValue)
        
        // instead of doing this for each button, we can add the helper method, then just do the above
//        let b0 = button(at: 0)
//        b0.tap()
//        // when I tap, I expect the button label to be the x string value
//        XCTAssertEqual(b0.label, Mark.x.stringValue)
        
    }
    
    func testXWins() {
        
        tapButton(0, expecting: .x)
        tapButton(1, expecting: .o)
        tapButton(2, expecting: .x)
        tapButton(5, expecting: .o)
        tapButton(4, expecting: .x)
        tapButton(3, expecting: .o)
        tapButton(6, expecting: .x)
        XCTAssertEqual(statusLabel.label, StatusTexts.win(.x).stringValue)
        
    }
    
    func testXWinsAndOTriesToKeepPlaying() {
        
        tapButton(0, expecting: .x)
        tapButton(1, expecting: .o)
        tapButton(2, expecting: .x)
        tapButton(5, expecting: .o)
        tapButton(4, expecting: .x)
        tapButton(3, expecting: .o)
        tapButton(6, expecting: .x)
        XCTAssertEqual(statusLabel.label, StatusTexts.win(.x).stringValue)
        
        let button = self.button(at: 7)
        button.tap()
        XCTAssertEqual(button.label, Mark.empty.stringValue)
        XCTAssertEqual(statusLabel.label, StatusTexts.win(.x).stringValue)
    }
    
    func testOWins() {
        tapButton(1, expecting: .x)
        tapButton(0, expecting: .o)
        tapButton(5, expecting: .x)
        tapButton(3, expecting: .o)
        tapButton(4, expecting: .x)
        tapButton(6, expecting: .o)
        XCTAssertEqual(statusLabel.label, StatusTexts.win(.o).stringValue)
    }
    
    func testTappingOnOtherOccupiedSquare() {
        tapButton(0, expecting: .x)
        tapButton(0, player: .o, expecting: .x) // o tries to tap on a square that already has an x
        tapButton(1, expecting: .o)
    }
    
    func testTappingOnOwnSquare() {
        tapButton(0, expecting: .x)
        tapButton(1, expecting: .o)
        tapButton(0, expecting: .x) // X tries to tap on its own tile
    }

}
