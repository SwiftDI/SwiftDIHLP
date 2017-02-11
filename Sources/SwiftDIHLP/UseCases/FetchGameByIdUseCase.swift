import Foundation

public class FetchGameByIdUseCase: UseCase {
    let id: UUID
    let observer: FetchGamesObserver
    let repo: GameRepository

    public init(id: UUID, observer: FetchGamesObserver, repo: GameRepository) {
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
