import UIKit

enum DoorsState {
    case open, close
}

enum EngineState {
    case isOn, isOff
}

enum TrunkAction {
    case loadTrunk(Int)
    case unloadTrunk(Int)
}

enum Action {
    case doors, engine
}

struct SportCar {
    let mark: String
    let release: Int
    let maxVolume: Int
    var volume: Int = 0
    var engineState: EngineState = .isOff
    var doorState: DoorsState = .close
    
    mutating func makeAction (action: Action) {
        switch action {
        case .doors:
            doorState = doorState == .close ? .open : .close
        case .engine:
            engineState = engineState == .isOff ? .isOn : .isOff
        }
    }
    
    mutating func makeTruncAction(trankAction: TrunkAction) {
        switch trankAction {
        case .loadTrunk(let load):
            if volume + load > maxVolume {
                print("НЕ ЛЕЗЕТ! Осталось место только для \(maxVolume - volume) кг добра")
                return
            } else {
                volume += load
            }
        case .unloadTrunk(let load):
            if volume - load == 0 {
                print("Багажник теперь пустой")
                volume -= load
                return
            } else if volume - load < 0 {
                print("В багажнике только \(volume) кг добра")
                return
            } else {
                volume -= load
            }
        }
        print("Багажник заполнен на \(volume) из \(maxVolume) кг")
    }
}

var car1 = SportCar(mark: "Zastava", release: 1980, maxVolume: 200)
var car2 = SportCar(mark: "Lada", release: 1999, maxVolume: 100)
car1.makeTruncAction(trankAction: .loadTrunk(50))
car1.makeTruncAction(trankAction: .loadTrunk(150))
car1.makeTruncAction(trankAction: .unloadTrunk(200))
