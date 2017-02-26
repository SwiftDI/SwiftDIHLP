import Quick
import Nimble
import SwiftDIHLP
import Foundation

class FetchGameSpec: QuickSpec {
    override func spec() {
        describe("fetch a game by id") {
            let observerSpy = FetchGameObserverSpy()
            let repo = FakeGameRepository()
            let fetchGameById = FetchGameById(observer: observerSpy, repo: repo)

            beforeEach() {
                observerSpy.reset()
                repo.deleteAll()
            }

            context("when the game exists") {
                it("calls the observer's fetched callback with the game") {
                    let game = Game(p1: "p1", p2: "p2", result: GameResult.Invalid)

                    waitUntil { done in
                        repo.save(game: game) {
                            (savedGame: Game) in

                            fetchGameById.execute(id: savedGame.id!)

                            expect(observerSpy.fetchedGame).to(equal(savedGame))
                            done()
                        }
                    }
                }
            }

            context("when the game does not exist") {
                it("calls the observer's gameNotFound callback") {
                    fetchGameById.execute(id: UUID())

                    expect(observerSpy.gameNotFoundWasCalled).to(beTrue())
                }
            }
        }
    }
}
