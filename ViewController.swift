import UIKit

class ViewController: UIViewController {
    //var game = Concentration(numberOfPairsOfCards : (cardButtons.count +1_/2)
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int{ //IndexOfOneAndOnlyFaceUpCard
    get {
        return (CardButtons.count+1)/2
    }
}

// hook life cycle
private( set )var flipCount=0{
    didSet {
        flipCountLabel.text = "Flips : \(flipCount)"
    }
}
    
@IBOutlet private weak var flipCountLabel: UILabel!
@IBOutlet private var newGameButton: UIButton!
@IBOutlet private var CardButtons: [UIButton]!
    
@IBAction private func touchCard(_ sender: UIButton) {
    flipCount+=1; //property oberver to observe flipCount property
    if let cardNumber = CardButtons.firstIndex(of: sender){
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
    }else{
        print("Chosen Card was not in cardButtons")
    }
}
    
@IBAction private func clickNewGame(_ sender: UIButton) {
    for index in CardButtons.indices {
        game.initializedCard(at: index)
        updateViewFromModel()
    }
}
    
private func updateViewFromModel(){
    for index in CardButtons.indices {
        let button = CardButtons[index]
        let card = game.cards[index]
        if card.isFaceUP{
            button.setTitle(emoji(for: card),for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        else {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor=card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
    }
}
    
private var emojiChoices: Array<String> = [ "🦇", "😱", "🙀", "😈",                                         "👻", "🎃", "🍭", "🍬", "🍎" ]
private var dictemoji: [Int: [String]] = [1 : [ "🦇", "😱", "🙀", "😈", "👻", "🎃", "🍭", "🍬", "🍎" ]
                              ,2 : [ "🐓", "🐤", "🐵", "🦄", "🐨", "🐧", "🐣", "🐼", "🦊" ]
                              ,3 : ["🏈", "🏀", "⚾️", "🥎", "🏐", "🎾", "🍭", "🍬", "🍎"]
                              ,4 : [ "😀", "🥲", "😍", "😎", "🤓", "🥸", "🤩", "😡", "🤗" ]]

private var emoji = [Int:String]() //dictionary

private func emoji(for card : Card) -> String {
    if emoji[card.identifier] == nil, emojiChoices.count > 0{ //Optional type -> nil처리를 해줘야함
        emoji[card.identifier]=emojiChoices.remove(at: emojiChoices.count.arc4random)
    }
    return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self))) // self is Int
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
    }
}

