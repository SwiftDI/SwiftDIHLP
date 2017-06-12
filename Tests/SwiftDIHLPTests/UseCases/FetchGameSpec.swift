import Quick
import Nimble
import SwiftDIHLP
import Foundation

class FetchGameSpec: QuickSpec {
    override func spec() {
        describe("fetch a game by id") {
            var repo: FakeGameRepository!
            var fetchGameById: FetchGameById!

            beforeEach() {
                repo = FakeGameRepository()
                fetchGameById = FetchGameById(repo: repo)
            }

            context("when the game exists") {
                it("calls the observer's fetched callback with the game") {
                    let game = Game(p1: "p1", p2: "p2", result: GameResult.Invalid)

                    waitUntil { done in
                        repo.save(game: game) {
                            (savedGame: Game) in

                            let observerSpy = FetchGameObserverSpy()
                            fetchGameById.execute(id: savedGame.id!, observer: observerSpy)

                            expect(observerSpy.fetchedGame).to(equal(savedGame))
                            done()
                        }
                    }
                }
            }

            context("when the game does not exist") {
                it("calls the observer's gameNotFound callback") {
                    let observerSpy = FetchGameObserverSpy()
                    fetchGameById.execute(id: UUID(), observer: observerSpy)

                    expect(observerSpy.gameNotFoundWasCalled).to(beTrue())
                }
            }
        }
    }
}
