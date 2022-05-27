import Foundation

var myDictionary: [String : Int] = [:]

print("총 몇명인가요?")
let n = Int(readLine()!)!

for _ in 0..<n {
    print("[name : price] 입력")
    let input = readLine()!.components(separatedBy: " ")
    let name = input[0]
    let price = Int(input[1])!
    myDictionary.updateValue(price, forKey: name)
}

var givers = myDictionary.filter { $0.value < 0 }
for key in givers.keys {
    givers[key]! *= -1
}

let takers = myDictionary.filter { $0.value > 0 }

var sortedGivers: Array<(key: String, value: Int)> = givers.sorted { $0.value > $1.value }
var sortedTakers: Array<(key: String, value: Int)> = takers.sorted { $0.value > $1.value }


mainLoop: while !(sortedGivers.isEmpty || sortedTakers.isEmpty) {
    // 같은거 처리부터 하면 완전 탐색을 해야해서 n^2으로 가야함
    // 정렬을 어차피 할거니까 정렬 후 같은거 처리하면 n logn으로 줄일 수 있음 (Jason 말씀해주신거)
    // 따라서 정렬을 먼저 하자
    
    
    
    // 정렬
    sortedGivers = descendingSort(sortedGivers)
    sortedTakers = descendingSort(sortedTakers)
    
    // 같은거 처리
    
    var i = 0
    var j = 0

    while i < sortedGivers.count && j < sortedTakers.count {
        if sortedGivers[i] == sortedTakers[j] {
            print("같은거 발견")
            i += 1
        } else if sortedGivers[i] < sortedTakers[j] {
            i += 1
        } else {
            j += 1
        }
    }
    
    
    
    // 큰거부터 처리
    
    
    
    
    
}

//Array<(key: String, value: Int)> 랑 Array<[String : Int]> 다른가보다?

func descendingSort(_ group: Array<(key: String, value: Int)>) -> Array<(key: String, value: Int)> {
    return group.sorted(by: { $0.value > $1.value })
}

func sendingFunction(from: String, to: String, amount: Int) {
    print("\(from) -> \(to) \t \(amount)원 송금")
}
