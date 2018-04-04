//
//  SharedDeck.swift
//  katz0210_a4
//
//  Created by Bradley Katz on 2018-02-26.
//  Copyright © 2018 Bradley Katz. All rights reserved.
//

import Foundation

class SharedDeck
{
    private static let instance = SharedDeck()
    
    private static let fileName = "cards.archive"
    private static let rootKey = "rootKey"
    private var deck: Deck?
    
    // Ensure that only one instance of SharedDeck can ever be created
    private init() { }
    
    private static func getDataFilePath() -> String
    {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        
        return documentsDirectory.appendingPathComponent(fileName) as String
    }
    
    public static func getDeck() -> Deck
    {
        return instance.deck!
    }
    
    public static func loadDeck()
    {
        let filePath = getDataFilePath()
        
        if (FileManager.default.fileExists(atPath: filePath))
        {
            let data = NSMutableData(contentsOfFile: filePath)!
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
            instance.deck = unarchiver.decodeObject(forKey: rootKey) as? Deck
            unarchiver.finishDecoding()
        }
        else
        {
            instance.deck = Deck()
        }
    }
    
    public static func saveDeck()
    {
        let filePath = SharedDeck.getDataFilePath()
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(SharedDeck.instance.deck, forKey: SharedDeck.rootKey)
        archiver.finishEncoding()
        data.write(toFile: filePath, atomically: true)
    }
}

