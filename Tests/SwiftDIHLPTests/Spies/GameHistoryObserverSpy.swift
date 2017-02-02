import SwiftDIHLP

class GameHistoryObserverSpy: GameHistoryObserver {
    var fetchedGames: [Game] = []

    func fetched(games: [Game]) {
        fetchedGames = games
    }

    func reset() {
        fetchedGames = []
    }
}
