import Quick
import Nimble
import SwiftDIHLP

class PlayGameUseCaseSpec: QuickSpec {
    override func spec() {

        describe("play") {
            let observer = PlayGameObserverSpy()
            let repo = FakeGameRepository()

            beforeEach() {
                observer.reset()
            }

            context("when p1 plays rock") {
                let p1 = "rock"

                context("and p2 plays rock") {
                    it("tells the observer that a tie occurred") {
                        PlayGameUseCase(p1: p1, p2: "rock", observer: observer, repo: repo).execute()

                        expect(observer.tieWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.Tie))
                    }
                }

                context("and p2 plays paper") {
                    it("tells the observer that p2 wins") {
                        PlayGameUseCase(p1: p1, p2: "paper", observer: observer, repo: repo).execute()

                        expect(observer.p2WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P2Wins))
                    }
                }

                context("and p2 plays scissors") {
                    it("tells the observer that p1 wins") {
                        PlayGameUseCase(p1: p1, p2: "scissors", observer: observer, repo: repo).execute()

                        expect(observer.p1WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P1Wins))
                    }
                }
            }

            context("when p1 plays paper") {
                let p1 = "paper"

                context("and p2 plays rock") {
                    it("tells the observer that p1 wins") {
                        PlayGameUseCase(p1: p1, p2: "rock", observer: observer, repo: repo).execute()

                        expect(observer.p1WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P1Wins))
                    }
                }

                context("and p2 plays paper") {
                    it("tells the observer that a tie occurred") {
                        PlayGameUseCase(p1: p1, p2: "paper", observer: observer, repo: repo).execute()

                        expect(observer.tieWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.Tie))
                    }
                }

                context("and p2 plays scissors") {
                    it("tells the observer that p2 wins") {
                        PlayGameUseCase(p1: p1, p2: "scissors", observer: observer, repo: repo).execute()

                        expect(observer.p2WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P2Wins))
                    }
                }
            }

            context("when p1 plays scissors") {
                let p1 = "scissors"

                context("and p2 plays rock") {
                    it("tells the observer that p2 wins") {
                        PlayGameUseCase(p1: p1, p2: "rock", observer: observer, repo: repo).execute()

                        expect(observer.p2WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P2Wins))
                    }
                }

                context("and p2 plays paper") {
                    it("tells the observer that p1 wins") {
                        PlayGameUseCase(p1: p1, p2: "paper", observer: observer, repo: repo).execute()

                        expect(observer.p1WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P1Wins))
                    }
                }

                context("and p2 plays scissors") {
                    it("tells the observer that a tie occurred") {
                        PlayGameUseCase(p1: p1, p2: "scissors", observer: observer, repo: repo).execute()

                        expect(observer.tieWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.Tie))
                    }
                }
            }

            context("when p1 plays an invalid throw") {
                it("tells the observer that an invalid game occurred") {
                    PlayGameUseCase(p1: "invalid", p2: "rock", observer: observer, repo: repo).execute()

                    expect(observer.invalidGameWasCalled).to(beTrue())
                    expect(observer.passedInGame!.result).to(equal(GameResult.Invalid))
                }
            }

            context("when p2 plays an invalid throw") {
                it("tells the observer that an invalid game occurred") {
                    PlayGameUseCase(p1: "rock", p2: "invalid", observer: observer, repo: repo).execute()

                    expect(observer.invalidGameWasCalled).to(beTrue())
                    expect(observer.passedInGame!.result).to(equal(GameResult.Invalid))
                }
            }
        }
    }
}
