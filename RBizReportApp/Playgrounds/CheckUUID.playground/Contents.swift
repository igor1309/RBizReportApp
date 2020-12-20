import Foundation

struct Test: Identifiable, Comparable {
    static func < (lhs: Test, rhs: Test) -> Bool {
        lhs.id == rhs.id && lhs.str == rhs.str
    }

    var id = UUID()
    var str = "Hello, playground"
}

extension Test {
    static var sample1: Test {
        Test(str: "Static var 1")
    }

    static func sample2() -> Test {
        Test(str: "Static func 2")
    }
}

let test11 = Test.sample1
let test21 = Test.sample2()

let test12 = Test.sample1
let test22 = Test.sample2()

print(test11 == test12, test11, test12) // swiftlint:disable:this print_using
print(test21 == test22, test21, test22) // swiftlint:disable:this print_using
