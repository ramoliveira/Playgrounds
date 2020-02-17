import UIKit
import PlaygroundSupport

// Algumas partes do código são open source, como a classe Double.

extension Double {
    func round(to places: Int) -> Double {
        let precisionNumber = pow(10, Double(places))
        var n = self
        n = n * precisionNumber
        n.round()
        n = n / precisionNumber
        return n
    }
}

var pi = 3.14159

pi.round(to: 4)

// Outras não, o que faz mais interessante ainda o uso de Extensions.
// Pois, não se conhece o código que o produziu, mas podemos adicionar
// funcionalidades.
extension UIButton {
    func makeCircular() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
}

let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

button.backgroundColor = .red
button.makeCircular()

// Extensions são úteis para implementações padrão do Swift.
// Caso queira previnir do programador que venhar usar o protocolo, não
// defina o método que será necessário. Pode-se dar uma implementação
// padrão.

class Monster {
    var life: Double = 100.0
    var name: String = "The Monster"
}

protocol Attack {
    var damage: Double { get set }
    
    func hit(target: Monster)
}

extension Attack {
    func hit(target: Monster) {
        target.life -= self.damage
    }
}

PlaygroundPage.current.finishExecution()
