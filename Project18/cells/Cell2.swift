//
//  Cell2.swift
//  Project18
//
//  Created by Niwat on 28/6/2567 BE.
//

import UIKit

class Cell2: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
