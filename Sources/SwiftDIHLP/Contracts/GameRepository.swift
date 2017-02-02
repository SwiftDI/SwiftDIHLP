public typealias SaveGameCompletion = (Game) -> Void
public typealias FetchGamesCompletion = ([Game]) -> Void

public protocol GameRepository {
    func save(game: Game, completion: SaveGameCompletion)
    func fetch(completion: FetchGamesCompletion)
    func deleteAll()
}
