public protocol PlayGameObserver {
    func p1Wins(game: Game)
    func p2Wins(game: Game)
    func tie(game: Game)
    func invalidGame(game: Game)
}

public class PlayGame {
    let observer: PlayGameObserver
    let repo: GameRepository

    let validThrows = ["rock", "paper", "scissors"]

    public init(observer: PlayGameObserver, repo: GameRepository) {
        self.observer = observer
        self.repo = repo
    }

    public func execute(p1: String, p2: String) {
        if (invalidGame(p1: p1, p2: p2)) {
            repo.save(game: Game(p1: p1, p2: p2, result: .Invalid)) {
                (game: Game) in
                self.observer.invalidGame(game: game)
            }
        } else if (p1 == p2) {
            repo.save(game: Game(p1: p1, p2: p2, result: .Tie)) {
                (game: Game) in
                self.observer.tie(game: game)
            }
        } else if (p1Wins(p1: p1, p2: p2)) {
            repo.save(game: Game(p1: p1, p2: p2, result: .P1Wins)) {
                (game: Game) in
                self.observer.p1Wins(game: game)
            }
        } else {
            repo.save(game: Game(p1: p1, p2: p2, result: .P2Wins)) {
                (game: Game) in
                self.observer.p2Wins(game: game)
            }
        }
    }

    private func p1Wins(p1: String, p2: String) -> Bool {
        return  (p1 == "rock" && p2 == "scissors") ||
                (p1 == "paper" && p2 == "rock") ||
                (p1 == "scissors" && p2 == "paper")
    }

    private func invalidGame(p1: String, p2: String) -> Bool {
        return !(validThrows.contains(p1) && validThrows.contains(p2))
    }
}
