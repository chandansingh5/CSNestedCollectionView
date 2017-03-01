//
//  CustomHeader.swift
//  DemoSwift
//
//  Created by Chandan Singh on 02/03/17.
//  Copyright © 2017 Chandan Singh. All rights reserved.
//

import UIKit

protocol HeaderSeeAllDelegate {
    func buttonseeAllTapped(headerTag:Int)
}

class CustomHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnSeeAll: UIButton!
    var buttonseeAllDelegate: HeaderSeeAllDelegate?

    @IBAction func seeAllbtnAction(_ sender: UIButton) {
        if let delegate = buttonseeAllDelegate {
            delegate.buttonseeAllTapped(headerTag: sender.tag)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
