//
//  DeckTableViewController.swift
//  katz0210_a4
//
//  Created by Bradley Katz on 2018-02-26.
//  Copyright © 2018 Bradley Katz. All rights reserved.
//

import UIKit

class DeckTableViewController: UITableViewController
{
    private static let displayCardSegueID = "displayCard"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        SharedDeck.loadDeck()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindToDeckList(sender: UIStoryboardSegue)
    {
        if let sourceViewController = sender.source as? AddCardViewController
        {
            if let newCard = sourceViewController.getCard()
            {
                let deck = SharedDeck.getDeck()
                
                let newIndexPath = IndexPath(row: deck.getSize(), section: 0)
                deck.appendCard(card: newCard)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return SharedDeck.getDeck().getSize()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as? CardTableViewCell else
        {
            fatalError("The aquired cell is not a CardTableViewCell")
        }

        // Get the appropriate card from the deck
        let currentCard = SharedDeck.getDeck().getCardAt(index: indexPath.row)
        
        // Set the cell properties
        cell.cellImageView.image = currentCard.getImage()
        cell.cellQuestionLabel.text = currentCard.getQuestion()

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            SharedDeck.getDeck().deleteCardAt(index: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == DeckTableViewController.displayCardSegueID
        {
            CardViewController.setCard(card: SharedDeck.getDeck().getCardAt(index: (tableView.indexPathForSelectedRow?.row)!))
        }
    }
}
