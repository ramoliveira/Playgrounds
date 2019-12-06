protocol Adicionavel {
    static func + (lhs: Self, rhs: Self) -> Self
}

func soma(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func soma(_ a: Int, _ b: Int, _ c: inout Int) {
    c = a + b
}

func soma<T: Numeric>(_ a: T, _ b: T) -> T {
    return a + b
}

func soma<T: Numeric>(_ a: T, _ b: T, _ c: inout T) {
    c = a + b
}

func soma<T: Adicionavel>(_ a: T, _ b: T) -> T {
    return a + b
}

func soma<T: Adicionavel>(_ a: T, _ b: T, _ c: inout T) {
    c = a + b
}

extension Int: Adicionavel {}
extension Double: Adicionavel {}
extension Float: Adicionavel {}

var c: Int = 0
soma(2, 4, &c)
c = soma(8, 7)
