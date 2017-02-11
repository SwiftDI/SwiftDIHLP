import SwiftDIHLP

class PlayGameObserverSpy: PlayGameObserver {
    var p1WinsWasCalled = false
    var p2WinsWasCalled = false
    var tieWasCalled = false
    var invalidGameWasCalled = false
    var passedInGame: Game? = nil

    func p1Wins(game: Game) {
        p1WinsWasCalled = true
        passedInGame = game
    }

    func tie(game: Game) {
        tieWasCalled = true
        passedInGame = game
    }

    func p2Wins(game: Game) {
        p2WinsWasCalled = true
        passedInGame = game
    }

    func invalidGame(game: Game) {
        invalidGameWasCalled = true
        passedInGame = game
    }

    func reset() {
        p1WinsWasCalled = false
        p2WinsWasCalled = false
        tieWasCalled = false
        invalidGameWasCalled = false
        passedInGame = nil
    }
}
