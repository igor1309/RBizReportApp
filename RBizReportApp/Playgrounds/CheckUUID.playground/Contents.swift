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

let test1_1 = Test.sample1
let test2_1 = Test.sample2()

let test1_2 = Test.sample1
let test2_2 = Test.sample2()

print(test1_1 == test1_2, test1_1, test1_2)
print(test2_1 == test2_2, test2_1, test2_2)

