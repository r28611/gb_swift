import UIKit

enum FareState {
    case isOn, isOff
}

enum Action {
    case changeFireState
    case putSandbag(Int)
    case abortSandbag
}

struct Ballon {
    let color: UIColor
    let label: String
    var sandbag: Int = 0
    var fireState: FareState = .isOff
    var height: Int = 0
    
    mutating func makeAction (action: Action) {
        switch action {
        case .changeFireState:
            fireState = fireState == .isOff ? .isOn : .isOff
            print("Состояние огня - \(fireState)")
        case .putSandbag(let number):
            sandbag += number
            print("Теперь есть \(sandbag) мешков с песком. Полетели!")
        case .abortSandbag:
            if sandbag - 1 <= 0 {
                print("Больше мешков нет - пора выкидывать людей")
            } 
            sandbag -= 1
            print("Теперь есть \(sandbag) мешков с песком")
        }
    }
    
}

var ballon1 = Ballon(color: .blue, label: "Balkania")
ballon1.makeAction(action: .putSandbag(2))
ballon1.makeAction(action: .changeFireState)
ballon1.makeAction(action: .abortSandbag)
ballon1.makeAction(action: .abortSandbag)
