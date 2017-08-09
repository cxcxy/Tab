let numbers = [1,2,3,4]
let result = numbers.map {$0 + 2}
print(result)

let optionalArray: [String?] = ["AA", nil, "BB", "CC"];
var optionalResult = optionalArray.flatMap{ $0 }
print(optionalResult)


