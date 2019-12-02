import UIKit

func checkBrackets(string: String) -> Int {
    var stack: [(bracket: Character, index: String.Index?)] = []
    var index: String.Index?
    
    for char in string {
        if isOpenBracket(char) {
            let index = string.firstIndex(of: char)
            stack.append((char, index))
        } else if isBracket(char)
            && (stack.isEmpty || !isBalancedBrackets(open: stack.removeLast().bracket, close: char))
        {
            index = string.firstIndex(of: char)
            break
        }
    }
    
    if let index = index?.utf16Offset(in: string) {
        return index + 1
    } else if let index = stack.last?.index?.utf16Offset(in: string) {
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
    "1asddf5[))",
    "gf(ddd[gh{ fd }fdf]",
    "{([]({}))[]}",
    "{1f[fl()gg;]!(F,).}",
    "34g]g(5t)",
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
