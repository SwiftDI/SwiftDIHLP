import Foundation

public class FetchGameByIdUseCase: UseCase {
    let id: UUID
    let observer: GameHistoryObserver
    let repo: GameRepository

    public init(id: UUID, observer: GameHistoryObserver, repo: GameRepository) {
        self.id = id
        self.observer = observer
        self.repo = repo
    }

    public func execute() {
        repo.fetch(id: id) {
            (game: Game?) in
            self.observer.fetched(game: game)
        }
    }
}
