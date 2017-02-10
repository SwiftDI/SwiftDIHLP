import XCTest
import Foundation

open class GameRepositoryTests: XCTestCase {
    public var gameRepository: GameRepository?

    static var allTests: [(String, (GameRepositoryTests) -> () throws -> Void)] {
        return [
            ("testSave_callsTheCompletionWithTheSavedGames", testSave_callsTheCompletionWithTheSavedGames),
            ("testFetchGames_whenThereAreNoSavedGames_callsTheCompletionWithEmptyArray", testFetchGames_whenThereAreNoSavedGames_callsTheCompletionWithEmptyArray),
            ("testFetchGames_whenThereIsASavedGame_callsTheCompletionWithTheGame", testFetchGames_whenThereIsASavedGame_callsTheCompletionWithTheGame),
            ("testFetchGameById_whenThereIsNoGameWithThatId_callsTheCompletionWithNil", testFetchGameById_whenThereIsNoGameWithThatId_callsTheCompletionWithNil),
            ("testFetchGameById_whenThereIsAGameWithTheId_callsTheCompletionWithTheFetchedGame", testFetchGameById_whenThereIsAGameWithTheId_callsTheCompletionWithTheFetchedGame)
        ]
    }

    override open func setUp() {
        super.setUp()
        guard let gameRepository = gameRepository else { return }
        gameRepository.deleteAll()
    }

    override open func tearDown() {
        super.tearDown()
        guard let gameRepository = gameRepository else { return }
        gameRepository.deleteAll()
    }

    public func testSave_callsTheCompletionWithTheSavedGames() {
        guard let gameRepository = gameRepository else { return }

        let game = Game(p1: "p1", p2: "p2", result: .Invalid)

        let e = expectation(description: "Saving game")
        gameRepository.save(game: game) { (savedGame: Game) in
            XCTAssertNotNil(savedGame.id)
            XCTAssertEqual(savedGame.p1, game.p1)
            XCTAssertEqual(savedGame.p2, game.p2)
            XCTAssertEqual(savedGame.result, game.result)
            e.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    public func testFetchGames_whenThereAreNoSavedGames_callsTheCompletionWithEmptyArray() {
        guard let gameRepository = gameRepository else { return }

        let e = expectation(description: "Fetching empty games")
        gameRepository.fetch() { (games: [Game]) in
            XCTAssertEqual(games, [])
            e.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    public func testFetchGames_whenThereIsASavedGame_callsTheCompletionWithTheGame() {
        guard let gameRepository = gameRepository else { return }

        let game = Game(p1: "p1", p2: "p2", result: .Invalid)

        let e = expectation(description: "Fetching games")
        gameRepository.save(game: game) { (savedGame: Game) in
            gameRepository.fetch() { (games: [Game]) in
                XCTAssertEqual(games.count, 1)
                let fetchedGame = games[0]
                XCTAssertEqual(fetchedGame.p1, game.p1)
                XCTAssertEqual(fetchedGame.p2, game.p2)
                XCTAssertEqual(fetchedGame.result, game.result)
                e.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    public func testFetchGameById_whenThereIsNoGameWithThatId_callsTheCompletionWithNil() {
        guard let gameRepository = gameRepository else { return }

        let e = expectation(description: "Fetching non-existent game")
        gameRepository.fetch(id: UUID()) { (game: Game?) in
            XCTAssertNil(game)
            e.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)

    }

    public func testFetchGameById_whenThereIsAGameWithTheId_callsTheCompletionWithTheFetchedGame() {
        guard let gameRepository = gameRepository else { return }

        let game = Game(p1: "p1", p2: "p2", result: .Invalid)

        let e = expectation(description: "Fetching game")
        gameRepository.save(game: game) { (savedGame: Game) in
            gameRepository.fetch(id: savedGame.id!) { (fetchedGame: Game?) in
                XCTAssertNotNil(fetchedGame)
                if let fetchedGame = fetchedGame {
                    XCTAssertEqual(fetchedGame.p1, game.p1)
                    XCTAssertEqual(fetchedGame.p2, game.p2)
                    XCTAssertEqual(fetchedGame.result, game.result)
                    e.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
