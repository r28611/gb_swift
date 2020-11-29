import UIKit

enum BallonState {
    case inflated, deflated
}

class Ballon {
    let color: UIColor
    let label: String?
    var ballonState: BallonState
    
    init(color: UIColor, label: String?, ballonState: BallonState) {
        self.color = color
        self.label = label
        self.ballonState = .deflated
    }
    
    convenience init(color: UIColor) {
        self.init(color: color, label: nil, ballonState: .deflated)
    }
    
    func inflateBallon() {
        ballonState = ballonState == .deflated ? .inflated : .deflated
    }
}

enum FareState {
    case isOn, isOff
}

enum BallonAeronauticsAction {
    case changeFireState
    case putSandbag(Int)
    case abortSandbag
}

class BallonAeronautics: Ballon {
    var sandbag: Int
    var fireState: FareState
    var height: Int
    
    init(color: UIColor, label: String?, ballonState: BallonState, sandbag: Int, fareState: FareState, height: Int) {
        self.sandbag = sandbag
        self.fireState = fareState
        self.height = height
        super.init(color: color, label: label, ballonState: ballonState)
    }
    
    convenience init(color: UIColor) {
        self.init(color: color, label: nil, ballonState: .deflated, sandbag: 0, fareState: .isOff, height: 0)
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

class PartyBallon: Ballon {
    var size: Int
    
    init(color: UIColor, label: String?, ballonState: BallonState, size: Int) {
        self.size = size
        super.init(color: color, label: label, ballonState: ballonState)
    }
    
    convenience init(color: UIColor) {
        self.init(color: color, label: nil, ballonState: .deflated, size: 1)
    }
    
    override func inflateBallon() {
        super.inflateBallon()
        size *= 5
        if let hadLabel = label {
            print("Шарик с надписью '\(hadLabel)' надули, он стал \(size) размера")
        } else {
            print("Обычный шарик надули, он стал \(size) размера")
        }
    }
}

let ballon1 = PartyBallon(color: .red, label: "Амиру!", ballonState: .deflated, size: 2)
let ballon2 = PartyBallon(color: .green)
let ballon3 = PartyBallon(color: .yellow, label: nil, ballonState: .deflated, size: 4)
let ballon4 = PartyBallon(color: .blue, label: "С днём рождения!", ballonState: .deflated, size: 3)

let ballonsForParty = [ballon1, ballon2, ballon3, ballon4]
for ballon in ballonsForParty {
    ballon.inflateBallon()
}

let ballon5 = BallonAeronautics(color: .orange)
ballon5.makeAction(action: .putSandbag(2))
ballon5.makeAction(action: .changeFireState)
ballon5.makeAction(action: .abortSandbag)

