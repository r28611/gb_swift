import UIKit

protocol Ballon {
    var color: UIColor { get }
    var label: String? { get }
}

protocol Inflateble : AnyObject {
    var ballonState: BallonState { get set }
    func inflate()
}

extension Inflateble {
    func inflate() {
        ballonState = ballonState == .deflated ? .inflated : .deflated
        print("Шар надут!")
    }
}

extension Inflateble where Self: PartyBallon {
    func inflate() {
        //Амир, вопрос - наверное можно следующую строку не повторять, а сделать типо:
        //self.inflateBallon()
        //но я не поняла как лучше сделать, чтобы функция не вызывала сама себя
        ballonState = ballonState == .deflated ? .inflated : .deflated
        size *= 5
        if let hadLabel = label {
            print("Шарик с надписью '\(hadLabel)' надули, он стал \(size) размера")
        } else {
            print("Обычный шарик надули, он стал \(size) размера")
        }
    }
}

enum BallonState {
    case inflated, deflated
}

enum FareState {
    case isOn, isOff
}

enum BallonAeronauticsAction {
    case changeFireState
    case putSandbag(Int)
    case abortSandbag
}

class BallonAeronautics: Ballon, Inflateble  {
    var color: UIColor
    var label: String?
    var ballonState: BallonState
    let maxSandbag: Int
    var sandbag: Int
    var fireState: FareState
    
    init(color: UIColor, label: String?, maxSandbag: Int) {
        self.color = color
        self.label = label
        self.ballonState = .deflated
        self.maxSandbag = maxSandbag
        self.sandbag = 0
        self.fireState = .isOff
    }
    
    func makeAction (action: BallonAeronauticsAction) {
        switch action {
        case .changeFireState:
            fireState = fireState == .isOff ? .isOn : .isOff
            ballonState = fireState == .isOn ? .inflated : .deflated
            print("Состояние огня - \(fireState)")
        case .putSandbag(let number):
            sandbag += number
            print("Теперь есть \(sandbag) мешков с песком. Полетели!")
        case .abortSandbag:
            if sandbag > 0 {
                sandbag -= 1
            }
            if sandbag == 0 {
                print("Мешков нет - пора выкидывать людей")
            } else {
                print("Теперь есть \(sandbag) мешков с песком")
            }
        }
    }
}

extension BallonAeronautics: CustomStringConvertible {
    var description: String {
        return "Этот воздушный шар вмещает \(maxSandbag) мешков с песком"
    }
}

class PartyBallon: Ballon, Inflateble {
    var color: UIColor
    var label: String?
    var ballonState: BallonState
    var size: Int
    
    init (color: UIColor, label: String?, size: Int) { self.color = color; self.label = label; ballonState = .deflated; self.size = size }
}

extension PartyBallon: CustomStringConvertible {
    var description: String {
        return "Это шарик \(color) цвета"
    }
}

extension Inflateble where Self: Boat {
    func inflate() {
        ballonState = ballonState == .deflated ? .inflated : .deflated
        print("Лодка надута - бери весло!")
    }
}

class Boat: Inflateble {
    var ballonState: BallonState
    
    init () {
        ballonState = .deflated
    }
}

let ballon1 = PartyBallon(color: .red, label: "Амиру!", size: 2)
let ballon2 = PartyBallon(color: .green, label: "Happy New Year!", size: 6)
let ballon3 = PartyBallon(color: .yellow, label: nil, size: 4)
let ballon4 = PartyBallon(color: .blue, label: "С днём рождения!", size: 3)
let ballon5 = BallonAeronautics(color: .cyan, label: "Siberia", maxSandbag: 20)
let boat = Boat()

let ballons = [ballon1, ballon2, ballon3, ballon4]
for ballon in ballons {
    ballon.inflate()
}

ballon5.inflate()
ballon5.makeAction(action: .putSandbag(2))
ballon5.makeAction(action: .changeFireState)
ballon5.makeAction(action: .abortSandbag)

boat.inflate()
