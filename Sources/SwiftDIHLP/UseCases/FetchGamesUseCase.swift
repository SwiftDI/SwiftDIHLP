public protocol GameHistoryObserver {
    func fetched(games: [Game])
    func fetched(game: Game?)
}

public class FetchGamesUseCase: UseCase {
    let observer: GameHistoryObserver
    let repo: GameRepository

    public init(observer: GameHistoryObserver, repo: GameRepository) {
        self.observer = observer
        self.repo = repo
    }

    public func execute() {
        repo.fetch { (games: [Game]) in
            self.observer.fetched(games: games)
        }
    }
}
