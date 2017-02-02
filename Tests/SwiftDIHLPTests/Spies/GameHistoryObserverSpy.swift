import SwiftDIHLP

class GameHistoryObserverSpy: GameHistoryObserver {
    var fetchedGames: [Game] = []
    var fetchedGame: Game?

    func fetched(games: [Game]) {
        fetchedGames = games
    }

    func fetched(game: Game?) {
        fetchedGame = game
    }

    func reset() {
        fetchedGames = []
    }
}
