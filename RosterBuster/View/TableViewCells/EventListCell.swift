//
//  EventListCell.swift
//  RosterBuster
//
//  Created by Vishal Sonawane on 11/10/19.
//  Copyright © 2019 Vishal Sonawane. All rights reserved.
//

import UIKit

class EventListCell: UITableViewCell {

    @IBOutlet weak var lblSourceToDestination:UILabel!
    @IBOutlet weak var lblTiming:UILabel!
    @IBOutlet weak var lblLayoverLocation:UILabel!
    @IBOutlet weak var lblMatchCrew:UILabel!
    @IBOutlet weak var lblIcon:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setup(event:Event)  {
        self.lblSourceToDestination.text = "S - > T"
        self.lblTiming.text = "timing"
        self.lblMatchCrew.text = "match crew"
        self.lblLayoverLocation.text = "AMS"
    }
}
