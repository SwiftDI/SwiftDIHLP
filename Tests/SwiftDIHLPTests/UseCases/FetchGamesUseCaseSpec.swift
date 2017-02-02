import Quick
import Nimble
import SwiftDIHLP

class FetchGamesUseCaseSpec: QuickSpec {
    override func spec() {
        describe("fetch games") {
            let observerSpy = GameHistoryObserverSpy()
            let repo = FakeGameRepository()

            beforeEach() {
                observerSpy.reset()
                repo.deleteAll()
            }

            describe("when no games have been played") {
                it("calls its closure with an empty array of games") {
                    let fetchGames = FetchGamesUseCase(observer: observerSpy, repo: repo)
                    fetchGames.execute()

                    expect(observerSpy.fetchedGames).to(equal([]))
                }
            }

            describe("when a game is played") {
                it("calls its closure with an array containing the game") {
                    let game = Game(p1: "rock", p2: "scissors", result: .P1Wins)

                    let play = PlayUseCase(p1: game.p1, p2: game.p2, observer: GameObserverSpy(), repo: repo)
                    play.execute()

                    let fetchGames = FetchGamesUseCase(observer: observerSpy, repo: repo)
                    fetchGames.execute()

                    expect(observerSpy.fetchedGames.count).to(equal(1))
                    let fetchedGame = observerSpy.fetchedGames[0]
                    expect(fetchedGame.p1).to(equal(game.p1))
                    expect(fetchedGame.p2).to(equal(game.p2))
                    expect(fetchedGame.result).to(equal(game.result))
                }
            }
        }
    }
}
