import Foundation

public typealias SaveGameCompletion = (Game) -> Void
public typealias FetchGamesCompletion = ([Game]) -> Void
public typealias FetchGameCompletion = (Game?) -> Void

public protocol GameRepository {
    func save(game: Game, completion: SaveGameCompletion)
    func fetch(completion: FetchGamesCompletion)
    func fetch(id: UUID, completion: FetchGameCompletion)
    func deleteAll()
}
