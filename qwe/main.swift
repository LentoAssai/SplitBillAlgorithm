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
    
    
    // 정산자가 딕셔너리에 없는 경우 예외 처리 추가하기
    
    print("\(i)차 참가자 이름 입력")
    for _ in 0..<numOfPerson {
        
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




var givers: [String : Int] = myDictionary.filter { $0.value < 0 }


// givers의 value가 음수이므로 양수로 바꾸기
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

// ------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------

// 송금

var numOfSending = 0


var giverIndex = 0
let takerIndex = 0

while(!(sortedGivers.isEmpty || sortedTakers.isEmpty)) {
    print(numOfSending + 1, "번째입니다.")
    
    print("giver number : \(sortedGivers.count)")
    print("taker number : \(sortedTakers.count)")
    
    // 같은거 있는지 확인 후 처리 (완전 탐색 말고 다른거 없나?)
    
    for i in 0..<sortedGivers.count {
        for j in 0..<sortedTakers.count {
            if sortedGivers[i].value == sortedTakers[j].value {
                
                print("\(sortedGivers[i].key)가 \(sortedTakers[j].key)에게 \(sortedGivers[i].value)원을 주었습니다.")
                
                numOfSending += 1
                sortedGivers.remove(at: i)
                sortedTakers.remove(at: j)
                
                continue
                // 여기서 continue하니까 안쪽 for문으로 가는듯
                // 제일 바깥 while 조건문으로 가야 되는데... 어떡하지??
                
            }
        }
    }
    
    
    
    giverIndex = 0
    
    
    
    // Taker < Giver 이면 다음 Giver로 넘어가기
    while sortedGivers[giverIndex].value > sortedTakers[takerIndex].value {
        
        if giverIndex >= sortedGivers.count - 1 {
            giverIndex = 0
            break
        }
        
        giverIndex += 1
        
    }
    
    
    let givingMoney = sortedGivers[giverIndex].value
    let takingMoney = sortedTakers[takerIndex].value
    
    //    print("GiverIndex : \(giverIndex)")
    print("givingMoney : ", givingMoney, "takingMoney : ", takingMoney)
    
    
    
    
    if givingMoney < takingMoney {
        
        sortedTakers[takerIndex].value -= givingMoney
        print("\(sortedGivers[giverIndex].key)가 \(sortedTakers[takerIndex].key)에게 \(givingMoney)원을 주었습니다.")
        
        sortedGivers.remove(at: giverIndex)
        
        
    } else {
        // 끝까지 갔는데 없어서 맨 위로 돌아온 경우
        sortedGivers[giverIndex].value -= takingMoney
        print("\(sortedGivers[giverIndex].key)가 \(sortedTakers[takerIndex].key)에게 \(takingMoney)원을 주었습니다.")
        
        sortedTakers.remove(at: takerIndex)
        
    }
    numOfSending += 1
    
    print()
}


print()
print("총 송금 횟수 : ", numOfSending)

