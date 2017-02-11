import SwiftDIHLP

class FetchGameObserverSpy: FetchGameObserver {
    var fetchedGame: Game?
    var gameNotFoundWasCalled = false

    func fetched(game: Game) {
        fetchedGame = game
    }

    func gameNotFound() {
        gameNotFoundWasCalled = true
    }

    func reset() {
        gameNotFoundWasCalled = false
    }
}
