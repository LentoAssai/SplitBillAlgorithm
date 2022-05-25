import Foundation



// 이름, 참가 여부 구조체
struct Person: Hashable {
    let name: String
    var participation: Bool
}

struct PersonList {
    
}

//----------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------






// 총 금액을 n명으로 나누어 각자 부담하는 금액 구하기
func splitBill(numOfMembers: Int, totalPrice: Int) -> Int {
    return totalPrice / numOfMembers
}


// 기존 딕셔너리에서 key가 Person(name: newPersonName, participation: false) 이고 value는 0원으로 가지는 사람 추가
func makeNewPerson(input: Dictionary<Person, Int>, newPersonName: String) -> Dictionary<Person, Int> {
    var returnDictionary = input
    returnDictionary.updateValue(0, forKey: Person(name: newPersonName, participation: false))
    return returnDictionary
}




//----------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------


func updateDictionary(_ input: Dictionary<Person, Int>, totalPrice: Int, newPersonName: String?) -> Dictionary<Person, Int> {
    
    //    1. 기존 딕셔너리에서 추가되는 사람 있으면 추가하기
    //    2. 누가 참가하고 누가 빠지는지 확인하기
    //    3. 이번 차수에서 n빵 할 금액 구하기
    //    4. 딕셔너리 최신화
    
    
    var returnDictionary = input
    
    
    // 만약 새로운 사람이 추가되었다면
    // 1. 기존 딕셔너리에서 추가되는 사람 있으면 추가하기
    if let newPersonName = newPersonName {
        returnDictionary = makeNewPerson(input: returnDictionary, newPersonName: newPersonName)
    }
    
    
    
    // 2. 누가 참가하고 누가 빠지는기 확인하기
    
    
    
    
    // 전체 딕셔너리 인원 중 이번 차수에 참여하는 사람 수
    let numOfCurrentMembers = 0
    
    
    
    
    
    
    
    // 3. 이번 차수에서 n빵 할 금액 구하기
    let splitedPrice = splitBill(numOfMembers: numOfCurrentMembers, totalPrice: totalPrice)
    
    
    
    
    // 4. 딕셔너리 최신화
    
    
    
    
    
    return returnDictionary

}



// 최신화된 딕셔너리로 Giver, Taker 나누기
func splitDictionary() -> Void {
    
}



// 나뉜 Giver, Taker section 각각 내림차순 정렬하기 (또는 Max Heap으로 구현)





// 먼저 Giver, Taker section 가운데 같은 값이 있으면 먼저 처리하고, 이후에 큰 값부터 처리하기
