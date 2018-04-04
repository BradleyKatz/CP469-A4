//
//  Card.swift
//  katz0210_a4
//
//  Created by Bradley Katz on 2018-02-26.
//  Copyright © 2018 Bradley Katz. All rights reserved.
//

import Foundation
import UIKit
import os

struct PropertyKeys
{
    private init() { } // We don't need any actual objects of this
    
    static let question = "question"
    static let answer = "answer"
    static let image = "image"
}

public class Card: NSObject, NSCoding
{
    public static let DEFAULT_IMAGE = UIImage(named: "???.png")
    
    let UNKNOWN = "???"
    
    private var question: String
    private var answer: String
    private var image: UIImage?
    
    public init?(question: String, answer: String, image: UIImage? = nil)
    {
        guard !question.isEmpty else { return nil }
        guard !answer.isEmpty else { return nil }
        
        self.question = question
        self.answer = answer
        
        if image != nil
        {
            self.image = image!
        }
        else
        {
            self.image = Card.DEFAULT_IMAGE
        }
    }
    
    required convenience public init?(coder aDecoder: NSCoder)
    {
        guard let question = aDecoder.decodeObject(forKey: PropertyKeys.question) as? String else
        {
            os_log("Unable to decode the question for a Card object")
            return nil
        }
        
        guard let answer = aDecoder.decodeObject(forKey: PropertyKeys.answer) as? String else
        {
            os_log("Unable to decode the answer for a Card object")
            return nil
        }
        
        let image = aDecoder.decodeObject(forKey: PropertyKeys.image) as? UIImage
        
        self.init(question: question, answer: answer, image: image!)
    }
    
    public func encode(with aCoder: NSCoder)
    {
        aCoder.encode(image, forKey: PropertyKeys.image)
        aCoder.encode(question, forKey: PropertyKeys.question)
        aCoder.encode(answer, forKey: PropertyKeys.answer)
    }
    
    func getQuestion() -> String
    {
        return self.question
    }
    
    func getAnswer() -> String
    {
        return self.answer
    }
    
    func getImage() -> UIImage
    {
        guard let imageToReturn = self.image as UIImage! else
        {
            return Card.DEFAULT_IMAGE!
        }
        
        return imageToReturn
    }
}


