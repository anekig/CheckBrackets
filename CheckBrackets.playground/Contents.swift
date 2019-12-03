import UIKit

func checkBrackets(string: String) -> Int {
    var stack: [(bracket: Character, index: Int?)] = []
    var unbalancedClosedBracketIndex: Int?
    
    for (i, char) in string.enumerated() {
        if isOpenBracket(char) {
            stack.append((char, i))
        } else if isBracket(char)
            && (stack.isEmpty || !isBalancedBrackets(open: stack.removeLast().bracket, close: char))
        {
            unbalancedClosedBracketIndex = i
            break
        }
    }
    
    if let index = unbalancedClosedBracketIndex {
        return index + 1
    } else if let index = stack.last?.index {
        return index + 1
    } else {
        return -1
    }
}

private func isOpenBracket(_ char: Character) -> Bool {
    return "{[(".contains(char)
}

private func isBracket(_ char: Character) -> Bool {
    return "{}[]()".contains(char)
}

private func isBalancedBrackets(open: Character, close: Character) -> Bool {
    return (open == "{" && close == "}")
        || (open == "[" && close == "]")
        || (open == "(" && close == ")")
}


// TESTING
let expressions = [
    "[1(a{a{",
    "[1[a[a",
    "gf(ddd[gh{ fd }fdf]",
    "{([]({}))[]}",
    "{1f[fl()gg;]!(F,).}",
    "34g]g(5t)",
    "34g]g(5t)]",
    "[]",
    "{}[]",
    "{[]}()",
    "{",
    "{[}",
    "foo(bar)",
    "foo(bar[i)"
]

for expression in expressions {
    let result = checkBrackets(string: expression)
    print("\(result) -> \(expression)")
}
