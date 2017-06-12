import Foundation

public protocol FetchGameObserver {
    func fetched(game: Game)
    func gameNotFound()
}

public class FetchGameById {
    let repo: GameRepository

    public init(repo: GameRepository) {
        self.repo = repo
    }

    public func execute(id: UUID, observer: FetchGameObserver) {
        repo.fetch(id: id) { (game: Game?) in
            if let game = game {
                observer.fetched(game: game)
            } else {
                observer.gameNotFound()
            }
        }
    }
}
