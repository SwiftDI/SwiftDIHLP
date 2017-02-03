import XCTest
import SwiftDIHLP

class FakeGameRepositoryTests: GameRepositoryTests {

    override func setUp() {
        gameRepository = FakeGameRepository()
        super.setUp()
    }

}
