import Foundation

var myDictionary: [String : Int] = [:]

print("몇차까지 달렸나요?")
let n = Int(readLine()!)!

for i in 1...n {
    print("\(i)차 몇명인가요?")
    let numOfPerson = Int(readLine()!)!
    
    print("\(i)차 총 금액 입력")
    let totalPrice = Int(readLine()!)!
    
    let splittedPrice = totalPrice / numOfPerson
    
    
    print("\(i)차 정산자는 누구?")
    let leader = readLine()!
    
    
    // 정산자가 딕셔너리에 없는 경우 예외 처리

    
    print("\(i)차 참가자 이름 입력")
    for _ in 0..<numOfPerson - 1 {
        
        let name = readLine()!
        if let curPrice = myDictionary[name] {
            // 기존에 인원이 있는 상황
            if name == leader {
                // 정산자라면
                myDictionary.updateValue(curPrice + splittedPrice * (numOfPerson - 1), forKey: name)
            } else {
                // 참여자라면
                myDictionary.updateValue(curPrice - splittedPrice, forKey: name)
            }
            
            
        } else {
            // 새로 인원이 추가된 상황
            if name == leader {
                // 정산자라면
                myDictionary.updateValue(splittedPrice * (numOfPerson - 1), forKey: name)
            } else {
                // 참여자라면
                myDictionary.updateValue(-splittedPrice, forKey: name)
            }
        }
        
    }
}
print("총 딕셔너리 : ", myDictionary)




// 0원으로 딱 떨어지는 경우 아예 빼버리기
var givers: [String : Int] = myDictionary.filter { $0.value < 0 }

for key in givers.keys {
    givers[key]! *= -1
}


let takers = myDictionary.filter { $0.value > 0 }

print("그냥 givers : ", givers)
print("그냥 takers : ", takers)

var sortedGivers = givers.sorted { $0.value > $1.value } // value의 절댓값이 큰 순서로 정렬
var sortedTakers = takers.sorted { $0.value > $1.value } // value의 절댓값이 큰 순서로 정렬

print("정렬 givers : ", sortedGivers)
print("정렬 takers : ", sortedTakers)



// Giver Taker 분류 완료






// 송금

// 절댓값이 같은 경우 먼저 처리하기

let numOfGivers = sortedGivers.count
let numOfTakers = sortedTakers.count

var numOfSending = 0


for i in 0..<numOfGivers {
    for j in 0..<numOfTakers {
        if sortedGivers[i].value == sortedTakers[j].value {
            
            numOfSending += 1
            sortedGivers.remove(at: i)
            sortedTakers.remove(at: j)
            
        }
    }
}


while(!(sortedGivers.isEmpty || sortedTakers.isEmpty)) {
    print(numOfSending + 1, "번째입니다.")
    let givingMoney = sortedGivers.first!.value // while문으로 nil이 아니라는 조건을 확인하였으므로 강제 언래핑
    let takingMoney = sortedTakers.first!.value
    
    print("givingMoney : ", givingMoney, "takingMoney : ", takingMoney)

    if givingMoney < takingMoney {
        sortedTakers[0].value -= givingMoney

        print("\(sortedGivers[0].key)가 \(sortedTakers[0].key)에게 \(givingMoney)원을 주었습니다.")

        sortedGivers.removeFirst()
    } else {
        sortedGivers[0].value -= takingMoney
        
        print("\(sortedGivers[0].key)가 \(sortedTakers[0].key)에게 \(takingMoney)원을 주었습니다.")

        sortedTakers.removeFirst()
    }
    
    numOfSending += 1
    
    print()
}



print("총 송금 횟수 : ", numOfSending)
