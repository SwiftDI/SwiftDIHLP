import Foundation

public protocol FetchGameObserver {
    func fetched(game: Game)
    func gameNotFound()
}

public class FetchGameByIdUseCase: UseCase {
    let id: UUID
    let observer: FetchGameObserver
    let repo: GameRepository

    public init(id: UUID, observer: FetchGameObserver, repo: GameRepository) {
        self.id = id
        self.observer = observer
        self.repo = repo
    }

    public func execute() {
        repo.fetch(id: id) { (game: Game?) in
            if let game = game {
                self.observer.fetched(game: game)
            } else {
                self.observer.gameNotFound()
            }
        }
    }
}
