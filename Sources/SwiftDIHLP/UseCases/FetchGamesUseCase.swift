public protocol FetchGamesObserver {
    func fetched(games: [Game])
    func fetched(game: Game)
    func gameNotFound()
}

public class FetchGamesUseCase: UseCase {
    let observer: FetchGamesObserver
    let repo: GameRepository

    public init(observer: FetchGamesObserver, repo: GameRepository) {
        self.observer = observer
        self.repo = repo
    }

    public func execute() {
        repo.fetch { (games: [Game]) in
            self.observer.fetched(games: games)
        }
    }
}
