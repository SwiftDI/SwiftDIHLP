import Quick
import Nimble
import SwiftDIHLP
import Foundation

class FetchGameUseCaseSpec: QuickSpec {
    override func spec() {
        describe("fetch a game by id") {
            let observerSpy = GameHistoryObserverSpy()
            let repo = FakeGameRepository()

            beforeEach() {
                observerSpy.reset()
                repo.deleteAll()
            }

            context("when the game exists") {
                it("calls the observer's callback with the game") {
                    let game = Game(p1: "p1", p2: "p2", result: GameResult.Invalid)

                    var savedGame: Game? = nil
                    repo.save(game: game) {
                        (game: Game) in
                        savedGame = game
                    }

                    let fetchGameById = FetchGameByIdUseCase(id: savedGame!.id!, observer: observerSpy, repo: repo)
                    fetchGameById.execute()

                    expect(observerSpy.fetchedGame).notTo(beNil())
                    expect(observerSpy.fetchedGame).to(equal(savedGame))
                }
            }

            context("when the game does not exist") {
                it("calls the observer's callback with nil") {
                    let fetchGameById = FetchGameByIdUseCase(id: UUID(), observer: observerSpy, repo: repo)
                    fetchGameById.execute()

                    expect(observerSpy.fetchedGame).to(beNil())
                }
            }
        }
    }
}
