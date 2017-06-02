//
//  RoundedUIView.swift
//  Rainy Shiny
//
//  Created by AADITYA NARVEKAR on 5/24/17.
//  Copyright © 2017 Aaditya Narvekar. All rights reserved.
//

import UIKit

class RoundedUIView: UIView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
    }

}
