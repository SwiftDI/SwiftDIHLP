import Quick
import Nimble
import SwiftDIHLP

class FetchGamesSpec: QuickSpec {
    override func spec() {
        describe("fetch games") {
            var repo: FakeGameRepository!
            var fetchGames: FetchGames!

            beforeEach() {
                repo = FakeGameRepository()
                fetchGames = FetchGames(repo: repo)
            }

            describe("when no games have been played") {
                it("calls its closure with an empty array of games") {
                    let observerSpy = FetchGamesObserverSpy()
                    fetchGames.execute(observer: observerSpy)

                    expect(observerSpy.fetchedGames).to(equal([]))
                }
            }

            describe("when a game is played") {
                it("calls its closure with an array containing the game") {
                    let game = Game(p1: "rock", p2: "scissors", result: .P1Wins)

                    PlayGame(repo: repo).execute(p1: game.p1, p2: game.p2, observer: PlayGameObserverSpy())

                    let observerSpy = FetchGamesObserverSpy()
                    fetchGames.execute(observer: observerSpy)

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
