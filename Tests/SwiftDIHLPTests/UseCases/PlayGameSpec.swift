import Quick
import Nimble
import SwiftDIHLP

class PlayGameSpec: QuickSpec {
    override func spec() {

        describe("play") {
            var repo: FakeGameRepository!
            var playGame: PlayGame!

            beforeEach() {
                repo = FakeGameRepository()
                playGame = PlayGame(repo: repo)
            }

            context("when p1 plays rock") {
                let p1 = "rock"

                context("and p2 plays rock") {
                    it("tells the observer that a tie occurred") {
                        let observer = PlayGameObserverSpy()

                        playGame.execute(p1: p1, p2: "rock", observer: observer)

                        expect(observer.tieWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.Tie))
                    }
                }

                context("and p2 plays paper") {
                    it("tells the observer that p2 wins") {
                        let observer = PlayGameObserverSpy()

                        playGame.execute(p1: p1, p2: "paper", observer: observer)

                        expect(observer.p2WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P2Wins))
                    }
                }

                context("and p2 plays scissors") {
                    it("tells the observer that p1 wins") {
                        let observer = PlayGameObserverSpy()

                        playGame.execute(p1: p1, p2: "scissors", observer: observer)

                        expect(observer.p1WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P1Wins))
                    }
                }
            }

            context("when p1 plays paper") {
                let p1 = "paper"

                context("and p2 plays rock") {
                    it("tells the observer that p1 wins") {
                        let observer = PlayGameObserverSpy()

                        playGame.execute(p1: p1, p2: "rock", observer: observer)

                        expect(observer.p1WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P1Wins))
                    }
                }

                context("and p2 plays paper") {
                    it("tells the observer that a tie occurred") {
                        let observer = PlayGameObserverSpy()

                        playGame.execute(p1: p1, p2: "paper", observer: observer)

                        expect(observer.tieWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.Tie))
                    }
                }

                context("and p2 plays scissors") {
                    it("tells the observer that p2 wins") {
                        let observer = PlayGameObserverSpy()

                        playGame.execute(p1: p1, p2: "scissors", observer: observer)

                        expect(observer.p2WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P2Wins))
                    }
                }
            }

            context("when p1 plays scissors") {
                let p1 = "scissors"

                context("and p2 plays rock") {
                    it("tells the observer that p2 wins") {
                        let observer = PlayGameObserverSpy()

                        playGame.execute(p1: p1, p2: "rock", observer: observer)

                        expect(observer.p2WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P2Wins))
                    }
                }

                context("and p2 plays paper") {
                    it("tells the observer that p1 wins") {
                        let observer = PlayGameObserverSpy()

                        playGame.execute(p1: p1, p2: "paper", observer: observer)

                        expect(observer.p1WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P1Wins))
                    }
                }

                context("and p2 plays scissors") {
                    it("tells the observer that a tie occurred") {
                        let observer = PlayGameObserverSpy()

                        playGame.execute(p1: p1, p2: "scissors", observer: observer)

                        expect(observer.tieWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.Tie))
                    }
                }
            }

            context("when p1 plays an invalid throw") {
                it("tells the observer that an invalid game occurred") {
                    let observer = PlayGameObserverSpy()

                    playGame.execute(p1: "invalid", p2: "rock", observer: observer)

                    expect(observer.invalidGameWasCalled).to(beTrue())
                    expect(observer.passedInGame!.result).to(equal(GameResult.Invalid))
                }
            }

            context("when p2 plays an invalid throw") {
                it("tells the observer that an invalid game occurred") {
                    let observer = PlayGameObserverSpy()

                    playGame.execute(p1: "rock", p2: "invalid", observer: observer)

                    expect(observer.invalidGameWasCalled).to(beTrue())
                    expect(observer.passedInGame!.result).to(equal(GameResult.Invalid))
                }
            }
        }
    }
}
