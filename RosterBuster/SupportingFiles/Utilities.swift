//
//  Utilities.swift
//  RosterBuster
//
//  Created by Vishal Sonawane on 14/10/19.
//  Copyright © 2019 Vishal Sonawane. All rights reserved.
//

import Foundation
import SVProgressHUD

class Utilities {
    static func showLoader(message:String){
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setBackgroundColor(.black)
        SVProgressHUD.show(withStatus: message)
    }
    static func hideLoader(){
        SVProgressHUD.dismiss()
    }
    
}
