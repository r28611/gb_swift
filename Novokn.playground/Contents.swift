import UIKit

enum BallonState {
    case inflated, deflated
}

protocol Ballon {
    var color: UIColor { get }
    var label: String? { get }
    var ballonState: BallonState { get set }
    
    func inflateBallon()
}

enum FareState {
    case isOn, isOff
}

enum BallonAeronauticsError: Error {
    case sandbagsOutOfStock
    case fareStateIsOff
}

class BallonAeronautics: Ballon {
    let color: UIColor
    let label: String?
    var ballonState: BallonState
    var sandbag: Int
    var fireState: FareState
    var height: Int
    
    init(color: UIColor, label: String?, ballonState: BallonState, sandbag: Int, fareState: FareState, height: Int) {
        self.color = color
        self.label = label
        self.ballonState = ballonState
        self.sandbag = sandbag
        self.fireState = fareState
        self.height = height
    }
    
    convenience init(color: UIColor) {
        self.init(color: color, label: nil, ballonState: .deflated, sandbag: 0, fareState: .isOff, height: 0)
    }
    
    func inflateBallon() {
        ballonState = ballonState == .deflated ? .inflated : .deflated
        self.fireState = .isOn
    }
    
    func putSandbag(amount: Int) {
        sandbag += amount
        print("Теперь есть \(sandbag) мешков с песком.")
    }
    
    func abortSandbag() -> (Int?, BallonAeronauticsError?) {
        guard sandbag > 0 else { return (nil, .sandbagsOutOfStock) }
        sandbag -= 1
        height += 5
        return (sandbag, nil)
    }
    
    func letsGoToHeight() -> (Int?, BallonAeronauticsError?) {
        guard fireState == .isOn else {return (nil, .fareStateIsOff) }
        guard sandbag > 0 else {return (nil, .sandbagsOutOfStock) }
        print("Полетели!")
        height += 10
        return (height, nil)
    }
}

var ballon = BallonAeronautics(color: .red)
ballon.inflateBallon()
ballon.putSandbag(amount: 10)
ballon.letsGoToHeight()
var ballonHeight = ballon.letsGoToHeight()
if let newHeigth = ballonHeight.0 {
    print("Мы поднялись на высоту \(newHeigth)")
} else if let error = ballonHeight.1 {
    print("Произошла ошибка: \(error.localizedDescription)")
}

enum OvenError: Error {
    case ovenIsEmpty
    case ovenIsFull
    case ovenIsOn
    case ovenIsOff
    case ovenIsClean
    case ovenIsDirty
}

enum OvenState {
    case clean, dirty
}

class Oven {
    var ingredients = [String]()
    var temperature: Double = 0
    var ovenState: OvenState = .clean
    
    func putIngredient(ingredient: String) {
        ingredients.append(ingredient)
    }
    
    func setTemperature(temperature: Double) {
        self.temperature = temperature
    }
    
    func cook() throws -> String {
        guard ovenState == .clean else {
            throw OvenError.ovenIsDirty
        }
        guard ingredients.count > 0 else {
            throw OvenError.ovenIsEmpty
        }
        guard temperature > 0 else {
            throw OvenError.ovenIsOff
        }
        var newMeal = "baked"
        for ingredient in ingredients {
            newMeal += ingredient
            ingredients.removeFirst()
            }
        self.ovenState = .dirty
        return newMeal
    }
    
    func clean() throws {
        guard ingredients.count == 0 else {
            throw OvenError.ovenIsFull
        }
        guard ovenState != .clean else {
            throw OvenError.ovenIsClean
        }
        guard temperature == 0 else {
            throw OvenError.ovenIsOn
        }
        ovenState = .clean
    }
}

let myOven = Oven()
myOven.putIngredient(ingredient: "apple")
myOven.putIngredient(ingredient: "sugar")
myOven.putIngredient(ingredient: "oatmeal")
myOven.setTemperature(temperature: 120.0)

do {
    try myOven.cook()
} catch OvenError.ovenIsOff {
    print("Духовка выключена - так не приготовить!")
} catch OvenError.ovenIsEmpty {
    print("Духовка пустая - надо что-то положить!")
} catch OvenError.ovenIsDirty {
    print("Духовка грязная - сначала надо помыть!")
}

myOven.setTemperature(temperature: 0.0)

do {
    try myOven.clean()
} catch OvenError.ovenIsOn {
    print("Духовка работает - не надо мыть")
} catch OvenError.ovenIsFull {
    print("Духовка не пустая")
} catch OvenError.ovenIsClean {
    print("Духовка чистая - не надо мыть.")
}

myOven.putIngredient(ingredient: "fish")
myOven.setTemperature(temperature: 180.0)

do {
    try myOven.cook()
} catch OvenError.ovenIsOff {
    print("Духовка выключена - так не приготовить!")
} catch OvenError.ovenIsEmpty {
    print("Духовка пустая - надо что-то положить!")
} catch OvenError.ovenIsDirty {
    print("Духовка грязная - сначала надо помыть!")
}
