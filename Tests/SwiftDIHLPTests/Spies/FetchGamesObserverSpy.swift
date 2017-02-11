import SwiftDIHLP

class FetchGamesObserverSpy: FetchGamesObserver {
    var fetchedGames: [Game] = []
    var fetchedGame: Game?
    var gameNotFoundWasCalled = false

    func fetched(games: [Game]) {
        fetchedGames = games
    }

    func fetched(game: Game) {
        fetchedGame = game
    }

    func gameNotFound() {
        gameNotFoundWasCalled = true
    }

    func reset() {
        fetchedGames = []
        gameNotFoundWasCalled = false
    }
}
