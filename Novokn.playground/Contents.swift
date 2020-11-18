import UIKit
import Foundation

//1. Написать функцию, которая определяет, четное число или нет.
func isEven (number: Int) -> Bool {
    return number % 2 == 0 ? true : false
}

//2. Написать функцию, которая определяет, делится ли число без остатка на 3.
func isDevideIn (number: Int, divider: Int) -> Bool {
    return number % divider == 0 ? true : false
}
//Example
isDevideIn(number: 5, divider: 3)

//3. Создать возрастающий массив из 100 чисел.
var arrayOfHundred = [Int] (1...100)

//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
let OddDividedIntoThree = arrayOfHundred.filter {!isEven(number: $0) && isDevideIn(number: $0, divider: 3) }

//5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.
//Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.

func addFibonacciNumbers (length: Int) -> [Int] {
    var array: [Int] = [0, 1]
    var fn: Int
    var count = 0
    while count < length - 2 {
        fn = array[count] + array[count + 1]
        array.append(fn)
        count += 1
    }
    return array
}

var fibonacciNumbers = addFibonacciNumbers(length: 50)

//6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:

//Функция проверяет простое ли число
func isPrime (number: Int) -> Bool {
    var count = number - 1
    while count != 1 {
        if number % count == 0 {
            return false
        } else {
            count -= 1
        }
    }
    return true
}

//Первое решение - все простые числа от 0 до 500
//Функция возвращает все простые числа в интервале от 1 до max
func primeNumbersToMax (max: Int) -> [Int] {
    var array: [Int] = []
    var count = 2
    while count <= max {
        if isPrime(number: count) {
            array.append(count)
        }
        count += 1
    }
    return array
}

let primeArray = primeNumbersToMax(max: 500)

//Второе решение - первые 100 простых чисел
//Функция возвращает массив простых чисел длиной length
func addPrimeNumbers (length: Int) -> [Int] {
    var array: [Int] = []
    var i = 2
    while array.count < length {
        if isPrime(number: i) {
            array.append(i)
        }
        i += 1
    }
    return array
}

let primeArray2 = addPrimeNumbers(length: 100)
