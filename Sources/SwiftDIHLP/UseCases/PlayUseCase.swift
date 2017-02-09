public class PlayUseCase: UseCase {
    let p1: String
    let p2: String
    let observer: GameObserver
    let repo: GameRepository

    let validThrows = ["rock", "paper", "scissors"]

    public init(p1: String, p2: String, observer: GameObserver, repo: GameRepository) {
        self.p1 = p1
        self.p2 = p2
        self.observer = observer
        self.repo = repo
    }

    public func execute() {
        if (invalidGame()) {
            repo.save(game: Game(p1: p1, p2: p2, result: .Invalid)) {
                (game: Game) in
                self.observer.invalidGame(game: game)
            }
        } else if (p1 == p2) {
            repo.save(game: Game(p1: p1, p2: p2, result: .Tie)) {
                (game: Game) in
                self.observer.tie(game: game)
            }
        } else if (p1Wins()) {
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

    private func p1Wins() -> Bool {
        return  (p1 == "rock" && p2 == "scissors") ||
                (p1 == "paper" && p2 == "rock") ||
                (p1 == "scissors" && p2 == "paper")
    }

    private func invalidGame() -> Bool {
        return !(validThrows.contains(p1) && validThrows.contains(p2))
    }
}

public protocol GameObserver {
    func p1Wins(game: Game)
    func p2Wins(game: Game)
    func tie(game: Game)
    func invalidGame(game: Game)
}
