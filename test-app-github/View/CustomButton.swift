//
//  CustomButton.swift
//  test-app-github
//
//  Created by Элина on 22.10.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.layer.backgroundColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1.00).cgColor
    }


}
