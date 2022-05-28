import Foundation

func SplitBillAlgorithm() {
    var sendingCount = 0
    let members = getUserInput()
    
    var sortedGivers = extractGivers(members)
    var sortedTakers = extractTakers(members)
    
    while !(sortedGivers.isEmpty || sortedTakers.isEmpty) {
        // 같은거 처리부터 하면 완전 탐색을 해야해서 n^2으로 가야함
        // 정렬을 어차피 할거니까 정렬 후 같은거 처리하면 n logn으로 줄일 수 있음 (Jason 말씀해주신거)
        // 따라서 정렬을 먼저 하자

        // 정렬
        sortedGivers = descendingSort(sortedGivers)
        sortedTakers = descendingSort(sortedTakers)
        
        // 같은거 처리
        handleSamePrice(sortedGivers, sortedTakers, &sendingCount)
        
        // 큰거부터 처리
        sendingFunction(&sortedGivers, &sortedTakers, &sendingCount)
        
    }
    
    print("총 정산 횟수 : \(sendingCount)")
}


func getUserInput() -> [String : Int] {
    var members: [String : Int] = [:]
    
    print("총 몇명인가요?")
    let n = Int(readLine()!)!
    
    for _ in 0..<n {
        
        print("[name, price] 입력. (Giver는 음수로, Taker는 양수로 입력, name과 price는 띄어쓰기로 구분)")
        let input = readLine()!.components(separatedBy: " ")
        let name = input[0]
        let price = Int(input[1])!
        members.updateValue(price, forKey: name)
        
    }
    
    return members
}

func extractGivers(_ members: [String : Int]) -> Array<(key: String, value: Int)> {
    return members.filter { $0.value < 0 }.map { ($0.key, -$0.value) }
}
func extractTakers(_ members: [String : Int]) -> Array<(key: String, value: Int)> {
    return members.filter { $0.value > 0 }
}


//Array<(key: String, value: Int)> 랑 Array<[String : Int]> 다른가보다?
func descendingSort(_ group: Array<(key: String, value: Int)>) -> Array<(key: String, value: Int)> {
    return group.sorted(by: { $0.value > $1.value })
}

func handleSamePrice(_ sortedGivers: [(key: String, value: Int)], _ sortedTakers: [(key: String, value: Int)], _ sendingCount: inout Int) {
    var i = 0
    var j = 0
    
    while i < sortedGivers.count && j < sortedTakers.count {
        if sortedGivers[i] == sortedTakers[j] {
            
            sendingMessage(from: sortedGivers[i].key, to: sortedTakers[j].key, amount: sortedGivers[i].value)
            i += 1
            sendingCount += 1
            
        } else if sortedGivers[i] < sortedTakers[j] {
            i += 1
        } else {
            j += 1
        }
    }
}

func sendingFunction(_ sortedGivers: inout [(key: String, value: Int)], _ sortedTakers: inout [(key: String, value: Int)], _ sendingCount: inout Int) {
    
    if sortedGivers[0].value < sortedTakers[0].value {
        
        sendingMessage(from: sortedGivers[0].key, to: sortedTakers[0].key, amount: sortedGivers[0].value)
        sortedTakers[0].value -= sortedGivers[0].value
        sortedGivers.remove(at: 0)
        
    } else {
        
        sendingMessage(from: sortedGivers[0].key, to: sortedTakers[0].key, amount: sortedTakers[0].value)
        sortedGivers[0].value -= sortedTakers[0].value
        sortedTakers.remove(at: 0)
        
    }
    
    sendingCount += 1
}

func sendingMessage(from: String, to: String, amount: Int) {
    print("\(from)이(가) \(to)에게 \(amount)원을 주었습니다.")
}


SplitBillAlgorithm()
