//
//  CardTableViewCell.swift
//  katz0210_a4
//
//  Created by Bradley Katz on 2018-02-26.
//  Copyright © 2018 Bradley Katz. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell
{
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellQuestionLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
