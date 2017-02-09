import Foundation

public typealias SaveGameCompletion = (Game) -> Void
public typealias FetchGamesCompletion = ([Game]) -> Void
public typealias FetchGameCompletion = (Game?) -> Void

public protocol GameRepository {
    func save(game: Game, completion: @escaping SaveGameCompletion)
    func fetch(completion: @escaping FetchGamesCompletion)
    func fetch(id: UUID, completion: @escaping FetchGameCompletion)
    func deleteAll()
}
