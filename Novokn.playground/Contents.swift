import UIKit

//1. Задайте коэффициенты квадратного уравнения ax2 + bx + c = 0
let a = 4.0
let b = 0.0
let c = -9.0

 //Считаем дискриминант
let d = (b*b) - (4*a*c)

//Считаем корни
if d < 0 {
    print("Корней нет.")
} else {
    let x1 = (-b + sqrt(d)) / (2*a)
    let x2 = (-b - sqrt(d)) / (2*a)
    if x1 == x2 {
        print("Ответ: \(x1)\n")
    } else {
        print("Ответ: \(x1), \(x2)\n")
        
    }
}


//2. Задайте катеты прямоугольного треугольника A и B
let sideA = 3.0
let sideB = 4.0

//Считаем гипотенузу по теореме Пифагора
let sideC = sqrt((pow(sideA, 2)) + (pow(sideB, 2)))

//Считаем периметр
let p = sideA + sideB + sideC

//Считаем площадь
let s = (sideA * sideB) / 2

print("Ответ: площадь - \(s), периметр - \(p), гипотенуза - \(sideC)\n")

//3. Введите сумму вклада, годовой процент и количество лет
var sum = 10000.00
let rate = 0.12
let period = 5

//Считаем сумму вклада по формуле простого процента
sum = sum * (1 + (rate * Double(period)))
print("Через \(period) лет сумма составит \(sum) евро\n")
