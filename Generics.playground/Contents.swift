protocol Adicionavel {
    static func + (lhs: Self, rhs: Self) -> Self
}

// 1) Função de soma de inteiros normal com retorno

func soma(_ a: Int, _ b: Int) -> Int {
    return a + b
}

// 2) Função de soma de inteiros sem retorno, usando o endereço
// de uma terceira variável para guardar o valor

func soma(_ a: Int, _ b: Int, _ c: inout Int) {
    c = a + b
}

// 3) Função de soma de Generics e retorno de um tipo Generic.
// Atribui-se o tipo Numeric para realizar a soma.

func soma<T: Numeric>(_ a: T, _ b: T) -> T {
    return a + b
}

// 4) Função de soma de Generics sem retorno, usando o endereço
// de uma terceira variável (também do tipo Generic) para guardar o valor

func soma<T: Numeric>(_ a: T, _ b: T, _ c: inout T) {
    c = a + b
}

// 5) Função de soma de Generics e retorno de um tipo Generic.
// A diferença está no protocolo Adicionável, que permite a adição
// ao criar a operação para o tipo.

func soma<T: Adicionavel>(_ a: T, _ b: T) -> T {
    return a + b
}

// 6) Função de soma de Generics sem retorno, usando o endereço
// de uma terceira variável (também do tipo Generic) para guardar o valor
// A diferença está no protocolo Adicionável, que permite a adição
// ao criar a operação para o tipo.

func soma<T: Adicionavel>(_ a: T, _ b: T, _ c: inout T) {
    c = a + b
}

// 5.1) Tipos somáveis devem estar em conformidade com o protocolo
// Adicionavel. Assim, eles poderão fazer as somas dos Generics.

extension Int: Adicionavel {}
extension Double: Adicionavel {}
extension Float: Adicionavel {}

var c: Int = 0
soma(2, 4, &c)
c = soma(8, 7)
