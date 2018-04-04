//
//  ViewController.swift
//  katz0210_a4
//
//  Created by Bradley Katz on 2018-02-26.
//  Copyright © 2018 Bradley Katz. All rights reserved.
//

import UIKit

class CardViewController: UIViewController
{
    @IBOutlet weak var uiImageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    
    private static var currentCard: Card?
    
    public static func setCard(card: Card)
    {
        currentCard = card
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        navigationItem.title = CardViewController.currentCard?.getQuestion()
        uiImageView.image = CardViewController.currentCard?.getImage()
        answerLabel.text = CardViewController.currentCard?.getAnswer()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.title = CardViewController.currentCard?.getQuestion()
        uiImageView.image = CardViewController.currentCard?.getImage()
        answerLabel.text = CardViewController.currentCard?.getAnswer()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onBackButtonPressed(_ sender: UIBarButtonItem)
    {
        CardViewController.currentCard = nil
        dismiss(animated: true, completion: nil)
    }
}

