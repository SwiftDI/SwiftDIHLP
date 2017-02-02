import Foundation

public struct Game {
    public let id: UUID?
    public let p1: String
    public let p2: String
    public let result: String

    public init(p1: String, p2: String, result: String) {
        self.init(p1: p1, p2: p2, result: result, id: nil)
    }

    public init(p1: String, p2: String, result: String, id: UUID?) {
        self.id = id
        self.p1 = p1
        self.p2 = p2
        self.result = result
    }
}

extension Game: Equatable {}

public func ==(lhs: Game, rhs: Game) -> Bool {
    guard let lhsId = lhs.id else { return false }
    guard let rhsId = rhs.id else { return false }
    return lhsId == rhsId
}
