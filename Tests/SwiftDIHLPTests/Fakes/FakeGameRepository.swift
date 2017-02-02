import SwiftDIHLP
import Foundation

class FakeGameRepository: GameRepository {
    var games: [Game] = []

    func save(game: Game, completion: SaveGameCompletion) {
        let savedGame = Game(p1: game.p1, p2: game.p2, result: game.result, id: UUID())
        games.append(savedGame)
        completion(savedGame)
    }

    func fetch(completion: FetchGamesCompletion) {
        completion(games)
    }

    func fetch(id: UUID, completion: FetchGameCompletion) {
        completion(games.filter({$0.id! == id}).first)
    }

    func deleteAll() {
        games = []
    }
}
