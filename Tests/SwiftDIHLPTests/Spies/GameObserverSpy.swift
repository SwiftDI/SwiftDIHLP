import SwiftDIHLP

class GameObserverSpy: GameObserver {
    var p1WinsWasCalled = false
    var p2WinsWasCalled = false
    var tieWasCalled = false
    var invalidGameWasCalled = false

    func p1Wins() {
        p1WinsWasCalled = true
    }

    func tie() {
        tieWasCalled = true
    }

    func p2Wins() {
        p2WinsWasCalled = true
    }

    func invalidGame() {
        invalidGameWasCalled = true
    }

    func reset() {
        p1WinsWasCalled = false
        p2WinsWasCalled = false
        tieWasCalled = false
        invalidGameWasCalled = false
    }
}
