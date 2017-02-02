import SwiftDIHLP

class FakeGameRepositorySpec: GameRepositorySpec {
    override func spec() {
        self.gameRepository = FakeGameRepository()

        super.spec()
    }
}
