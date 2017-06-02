//
//  DropShadowUIView.swift
//  Rainy Shiny
//
//  Created by AADITYA NARVEKAR on 5/24/17.
//  Copyright © 2017 Aaditya Narvekar. All rights reserved.
//

import UIKit

class DropShadowUIView: UIView {

    override func awakeFromNib() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 1.5
        self.layer.shadowOpacity = 0.75
        self.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        self.layer.masksToBounds = false
    }

}
