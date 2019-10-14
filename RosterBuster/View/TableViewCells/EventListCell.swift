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
        lblSourceToDestination.textColor = .black
        lblLayoverLocation.textColor = .gray
        lblTiming.textColor = .red
        lblMatchCrew.textColor = .gray
        selectionStyle = .none
    }
    func setup(event:Event)  {
        self.lblSourceToDestination.text = event.sourceToDestinationText
        self.lblTiming.text = event.timeText
        //Assumption: from the screenshot which was provided, assumption is made that if dutyCode is layover then only show this label
        self.lblMatchCrew.text = event.matchCrewText
        self.lblLayoverLocation.text = event.layoverLocationText
        
        if let dutyCode = event.dutyCode{
            self.lblIcon.setIconForEventType(type: EventType(rawValue: dutyCode.lowercased()) ?? EventType.undifined)
        }
        
    }
}
