import Foundation

public protocol FetchGameObserver {
    func fetched(game: Game)
    func gameNotFound()
}

public class FetchGameById {
    let observer: FetchGameObserver
    let repo: GameRepository

    public init(observer: FetchGameObserver, repo: GameRepository) {
        self.observer = observer
        self.repo = repo
    }

    public func execute(id: UUID) {
        repo.fetch(id: id) { (game: Game?) in
            if let game = game {
                self.observer.fetched(game: game)
            } else {
                self.observer.gameNotFound()
            }
        }
    }
}
