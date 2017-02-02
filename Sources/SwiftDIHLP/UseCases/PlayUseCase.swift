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
        var result = ""
        if (invalidGame()) {
            result = "invalid"
        } else if (p1 == p2) {
            result = "tie"
        } else if (p1Wins()) {
            result = "p1"
        } else {
            result = "p2"
        }

        let game = Game(p1: p1, p2: p2, result: result)
        repo.save(game: game) { (game: Game) in }

        if (invalidGame()) {
            observer.invalidGame()
        } else if (p1 == p2) {
            observer.tie()
        } else if (p1Wins()) {
            observer.p1Wins()
        } else {
            observer.p2Wins()
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
    func p1Wins()
    func p2Wins()
    func tie()
    func invalidGame()
}
