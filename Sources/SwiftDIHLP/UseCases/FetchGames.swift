public protocol FetchGamesObserver {
    func fetched(games: [Game])
}

public class FetchGames {
    let repo: GameRepository

    public init(repo: GameRepository) {
        self.repo = repo
    }

    public func execute(observer: FetchGamesObserver) {
        repo.fetch { (games: [Game]) in
            observer.fetched(games: games)
        }
    }
}
