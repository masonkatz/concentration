extension Array {
    var only: Element? { count == 1 ? first : nil }
}

extension Array where Element: Equatable {
    func firstIndex(matching element: Element) -> Int? {
        firstIndex(where: { $0 == element })
    }
}
