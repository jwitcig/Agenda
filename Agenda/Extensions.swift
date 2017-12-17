//
//  Extensions.swift
//  Agenda
//
//  Created by Developer on 9/17/17.
//  Copyright © 2017 JwitApps. All rights reserved.
//

import UIKit

public extension UIView {
    func removeSafelyFromSuperview() {
        if superview != nil {
            removeFromSuperview()
        }
    }
}
