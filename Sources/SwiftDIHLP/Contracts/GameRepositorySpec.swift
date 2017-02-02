import Quick
import Nimble
import SwiftDIHLP

class GameRepositorySpec: QuickSpec {
    var gameRepository: GameRepository? = nil

    override func spec() {
        guard let gameRepository = gameRepository else { return }

        beforeEach() {
            gameRepository.deleteAll()
        }

        describe("save") {
            it("calls its completion with the saved game") {
                let game = Game(p1: "p1", p2: "p2", result: "result")
                var capturedGame: Game? = nil

                gameRepository.save(game: game) {
                    (savedGame: Game) in
                    capturedGame = savedGame
                }

                guard let savedGame = capturedGame else {
                    fail()
                    return
                }

                expect(savedGame.id).notTo(beNil())
                expect(savedGame.p1).to(equal(game.p1))
                expect(savedGame.p2).to(equal(game.p2))
                expect(savedGame.result).to(equal(game.result))
            }
        }

        describe("fetch") {
            context("when there are no saved games") {
                it("calls its completion with an empty array") {
                    var fetchedGames: [Game] = []

                    gameRepository.fetch() {
                        (games: [Game]) in
                        fetchedGames = games
                    }

                    expect(fetchedGames).to(equal([]))
                }
            }

            context("when there is a saved game") {
                var fetchedGames: [Game] = []

                let game = Game(p1: "p1", p2: "p2", result: "result")
                gameRepository.save(game: game) {
                    (savedGame: Game) in
                }

                gameRepository.fetch() {
                    (games: [Game]) in
                    fetchedGames = games
                }

                expect(fetchedGames.count).to(equal(1))
                let fetchedGame = fetchedGames[0]
                expect(fetchedGame.p1).to(equal(game.p1))
                expect(fetchedGame.p2).to(equal(game.p2))
                expect(fetchedGame.result).to(equal(game.result))
            }
        }
    }
}
