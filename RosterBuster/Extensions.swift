//
//  Extensions.swift
//  RosterBuster
//
//  Created by Vishal Sonawane on 12/10/19.
//  Copyright © 2019 Vishal Sonawane. All rights reserved.
//

import Foundation
import FontAwesome_swift

extension UILabel{
    func setIconForEventType(type:EventType){
        self.font = UIFont.fontAwesome(ofSize: 25, style: .solid)
        switch type {
        case .flight:
            self.text = String.fontAwesomeIcon(name: .planeDeparture)
        case .off:
            self.text = String.fontAwesomeIcon(name: .powerOff)
        case .layover:
            self.text = String.fontAwesomeIcon(name: .suitcase)
        case .positioning:
            self.text = String.fontAwesomeIcon(name: .arrowsAlt)
        case .standby:
            self.text = String.fontAwesomeIcon(name: .fileAlt)
        case .undifined:
            self.text = String.fontAwesomeIcon(name: .questionCircle)
        }
    }
}
