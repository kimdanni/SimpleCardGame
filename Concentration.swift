import Foundation
class Concentration
{
// 클래스의 프로퍼티가 초기값을 가지는 인자없는 free initializer를 가짐 초기화 충분하지 않음
private ( set ) var cards = [Card]()
private var indexOfOneAndOn1yFaceUPCard : Int? {
    get {
        var foundIndex: Int?
        for index in cards.indices {
            if cards[index].isFaceUP {
                if foundIndex == nil {
                    foundIndex = index
                } else {
                    return nil
                }
            }
        }
        return foundIndex
    }
    set { //(newValue) 생략가능
// true for the touched card. false for the other cards
        for index in cards.indices {
            cards[index].isFaceUP = (index == newValue)
        }
    }
}
//var cards : Array<Card> = []
// var cards = Array<Card>() //empty
// var indexOfOneAndOnlyFaceUpCard : Int?
func chooseCard(at index:Int){
    assert(cards.indices.contains(index),"Concentration.chooseCard(at: \(index)): chosen index not in the cards")
    if !cards[index].isMatched{
    //check if card match
        if let matchIndex = indexOfOneAndOn1yFaceUPCard, matchIndex != index{ //check if card match
            if cards[matchIndex].identifier == cards[index].identifier{
                cards[matchIndex].isMatched = true
                cards[index].isMatched      = true
            }
            cards[index].isFaceUP = true
        } else{
    // either no cards or 2 cars are faced up
            indexOfOneAndOn1yFaceUPCard = index
        }
    //cards[index].isFaceUp = !cards[index].isFaceUp
    }
}
    
func initializedCard(at index:Int){
    assert(cards.indices.contains(index),"Concentration.chooseCard(at: \(index)): chosen index not in the cards")
    if cards[index].isMatched{
        cards[index].isMatched = false
    }
    if cards[index].isFaceUP{
        cards[index].isFaceUP = false
    }
}
    
init(numberOfPairsOfCards : Int) {
    assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(numberOfPairsOfCards)): you must have at least one pair of cards")
    for _ in 1...numberOfPairsOfCards {
        let card = Card()
        cards += [card, card]
    }
    //TODO : Shuffle the cards
    for _ in 1...cards.count {
        let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
        cards.swapAt(0, randomIndex)
        }
    }
}
