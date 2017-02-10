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
        var capturedGame: Game? = nil

        gameRepository.save(game: game) {
            (savedGame: Game) in
            capturedGame = savedGame
        }

        guard let savedGame = capturedGame else {
            XCTFail()
            return
        }

        XCTAssertNotNil(savedGame.id)
        XCTAssertEqual(savedGame.p1, game.p1)
        XCTAssertEqual(savedGame.p2, game.p2)
        XCTAssertEqual(savedGame.result, game.result)
    }

    public func testFetchGames_whenThereAreNoSavedGames_callsTheCompletionWithEmptyArray() {
        guard let gameRepository = gameRepository else { return }

        var fetchedGames: [Game] = []

        gameRepository.fetch() {
            (games: [Game]) in
            fetchedGames = games
        }

        XCTAssertEqual(fetchedGames, [])
    }

    public func testFetchGames_whenThereIsASavedGame_callsTheCompletionWithTheGame() {
        guard let gameRepository = gameRepository else { return }

        var fetchedGames: [Game] = []

        let game = Game(p1: "p1", p2: "p2", result: .Invalid)
        gameRepository.save(game: game) {
            (savedGame: Game) in
        }

        gameRepository.fetch() {
            (games: [Game]) in
            fetchedGames = games
        }

        XCTAssertEqual(fetchedGames.count, 1)
        let fetchedGame = fetchedGames[0]
        XCTAssertEqual(fetchedGame.p1, game.p1)
        XCTAssertEqual(fetchedGame.p2, game.p2)
        XCTAssertEqual(fetchedGame.result, game.result)
    }

    public func testFetchGameById_whenThereIsNoGameWithThatId_callsTheCompletionWithNil() {
        guard let gameRepository = gameRepository else { return }

        var fetchedGame: Game? = nil

        gameRepository.fetch(id: UUID()) {
            (game: Game?) in
            fetchedGame = game
        }

        XCTAssertNil(fetchedGame)
    }

    public func testFetchGameById_whenThereIsAGameWithTheId_callsTheCompletionWithTheFetchedGame() {
        guard let gameRepository = gameRepository else { return }

        var fetchedGame: Game? = nil

        let game = Game(p1: "p1", p2: "p2", result: .Invalid)
        var savedGame: Game? = nil
        gameRepository.save(game: game) {
            (game: Game) in
            savedGame = game
        }

        gameRepository.fetch(id: savedGame!.id!) {
            (game: Game?) in
            fetchedGame = game
        }

        XCTAssertNotNil(fetchedGame)
        if let fetchedGame = fetchedGame {
            XCTAssertEqual(fetchedGame.p1, game.p1)
            XCTAssertEqual(fetchedGame.p2, game.p2)
            XCTAssertEqual(fetchedGame.result, game.result)
        }
    }
}
