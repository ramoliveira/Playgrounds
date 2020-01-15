import PlaygroundSupport
import Foundation

// Executa tasks na thread main/UI thread
func executeMainQueue() {
    DispatchQueue.main.async {
        print("Hey, main dq async")
    }
}

// Executa tasks na thread de background
func executeGlobalQueue() {
    DispatchQueue.global().async {
        print("Hey, global dq async")
    }
}

// Pode-se criar a própria queue
// GCD = Grand Dispatch Queue
func executeOwnQueue() {
    let queue = DispatchQueue(label: "com.gcd.simpleQueue")

    queue.async {
        for _ in 1...5 {
            print("Clap... Clap... 👏")
        }
    }
}

// Executa a queue syncronous, com a queue sincronizada o segundo for espera o primeiro terminar
func executeSync() {
    let queue = DispatchQueue(label: "com.gcd.executeSync")
    print("Start race:")
    queue.sync {
        for i in 1...5 {
            print("🐢 @ \(i) Km.")
        }
    }
    
    for i in 1...5 {
        print("🐇 @ \(i) Km.")
    }
}

// Executa a queue asyncronous, com a queue assíncrona o segundo for não espera o primeiro terminar
func executeAsync() {
    let queue = DispatchQueue(label: "com.gcd.executeAsync")
    print("Start race:")
    queue.async {
        for i in 1...5 {
            print("🐢 @ \(i) Km.")
        }
    }
    
    for i in 1...5 {
        print("🐇 @ \(i) Km.")
    }
}

// Executa as queues asyncronous, como uma vem após a outra, o segundo for só executará quando o primeiro terminar
func serialExecution() {
    let queue = DispatchQueue(label: "com.gcd.serialExecution")
    print("Start race:")
    queue.async {
        for i in 1...5 {
            print("🐢 @ \(i) Km.")
        }
    }

    queue.async {
        for i in 1...5 {
            print("🐇 @ \(i) Km.")
        }
    }
}

// Executa as queues concurrent, para definir que as queues assíncronas devem executar ao mesmo tempo
// deve-se especificar que a execução deve ser concorrente
func concurrentExecution() {
    let queue = DispatchQueue(label: "com.gcd.concurrentExecution", qos: .userInitiated, attributes: .concurrent)
    print("Start race:")
    queue.async {
        for i in 1...5 {
            print("🐢 @ \(i) Km.")
        }
    }
    
    queue.async {
        for i in 1...5 {
            print("🐇 @ \(i) Km.")
        }
    }
}

// Quality of Service (QoS or qos)
// Sequência de prioridade:
/*
 .userInteractive -> Thread que roda na main/UI thread, logo a mais importante
 .userInitiated
 .default
 .utility
 .background -> Thread que roda no background, logo a menos importante
 .unspecified
 */
// Todas as threads são terminadas
// Mas quem será dada prioridade é definida através dos itens acima ☝️
// Se nenhuma prioridade é definida, o valor é .default para ela

func checkQos() {
    let queue1 = DispatchQueue(label: "com.gcd.simpleQueue1", qos: .userInteractive)
    let queue2 = DispatchQueue(label: "com.gcd.simpleQueue2", qos: .background)
    
    print("Start race:")
    queue1.async {
        for i in 1...5 {
            print("🐢 @ \(i) Km.")
        }
    }
    
    queue2.async {
        for i in 1...5 {
            print("🐇 @ \(i) Km.")
        }
    }
}

// Existem queues padrões feitas pelo GCD, como: main e global
// Esta é a queue global, feita para execuções no background como baixar um arquivo, carregar dados, ou executar
// pesquisa
func globalQueue() {
    let globalQueue = DispatchQueue.global()
    // Pode-se definir a prioridade desta queue também
    /*
        let globalQueue = DispatchQueue.global(qos: .userInitiated)
     */
    
    globalQueue.async {
        for i in 1...5 {
            print("\(i)")
        }
    }
}

// Esta é a queue main, feita para execuções na interface como atualizar a tela e etc.
// É interessante tentar manter operações de UI na main, senão o compilador pode reclamar

/*
func mainQueue() {
    DispatchQueue.main.async {
        self.view.backgroundColor = UIColor.red
    }
}
*/

// Execução atrasada, pode-se iniciar uma queue apenas após um tempo
// Pode-se especificar este intervalo em:
/*
    .seconds(Int)
    .miliseconds(Int)
    .microseconds(Int)
    .nanoseconds(Int)
 */
func delayedExecution() {
    let queue = DispatchQueue(label: "com.gcd.delayedQueue")
    
    let delayedInterval = DispatchTimeInterval.seconds(5)
    print(Date())
    
    queue.asyncAfter(deadline: .now() + delayedInterval) {
        print(Date())
    }
}

// DispatchWorkItem é um modo de executar um código na queue que está rodando atualmente
let dispatchWorkItem = DispatchWorkItem {
    print("WorkItem executed!")
}

// Pode pedir para ser executado assim:
dispatchWorkItem.perform()

// Ou adicionando a uma queue
DispatchQueue.global().async(execute: dispatchWorkItem)

// Pode-se pedir para executar a mesma tarefa por várias interações
func concurrentPerform() {
    DispatchQueue.concurrentPerform(iterations: 5) { (i) in
        print("Interation: \(i)")
    }
}



PlaygroundPage.current.finishExecution()
