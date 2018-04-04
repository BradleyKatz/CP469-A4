//
//  Deck.swift
//  katz0210_a4
//
//  Created by Bradley Katz on 2018-02-26.
//  Copyright © 2018 Bradley Katz. All rights reserved.
//

import Foundation

struct DeckPropertyKeys
{
    private init() { }
    
    static let cards = "cardsKey"
}

public class Deck: NSObject, NSCoding
{
    private var cards: [Card] = []
    
    override init()
    {
        super.init()
    }
    
    required convenience public init?(coder decoder: NSCoder)
    {
        self.init()
        cards = (decoder.decodeObject(forKey: DeckPropertyKeys.cards) as? [Card])!
    }
    
    public func encode(with coder: NSCoder)
    {
        coder.encode(cards, forKey: DeckPropertyKeys.cards)
    }
    
    public func getCardAt(index: Int) -> Card
    {
        if !cards.isEmpty && index >= 0 && index <= cards.count
        {
            return cards[index]
        }
        else
        {
            fatalError("Card index out of range")
        }
    }
    
    public func appendCard(card: Card)
    {
        cards.append(card)
    }
    
    public func getSize() -> Int
    {
        return cards.count
    }
    
    public func deleteCardAt(index: Int)
    {
        if !cards.isEmpty && index >= 0 && index <= cards.count
        {
            cards.remove(at: index)
        }
        else
        {
            fatalError("Card index out of range")
        }
    }
    
    public func isEmpty() -> Bool
    {
        return cards.isEmpty
    }
}

