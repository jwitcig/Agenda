//
//  ViewController.swift
//  Agenda
//
//  Created by Developer on 9/12/17.
//  Copyright © 2017 JwitApps. All rights reserved.
//

import UIKit

import Cartography

class ViewController: UIViewController {

    let timeStackView = UIStackView()
    
    var selections: [UIView] = []
    var currentSelection: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupClock()
    }
    
    func setupClock() {
        timeStackView.axis = .vertical
        timeStackView.alignment = .leading
        timeStackView.distribution = .equalSpacing
        
        let clockTimes = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
        let times = clockTimes + clockTimes // AM and PM
        
        for (index, time) in times.enumerated() {
            let label = UILabel()
            label.text = index < 12 ? "\(time) am" : "\(time) pm"
            
            timeStackView.addArrangedSubview(label)
        }
        
        view.addSubview(timeStackView)
        constrain(timeStackView, view) {
            $0.top == $1.top
            $0.bottom == $1.bottom
            $0.leading == $1.leading
            $0.trailing == $1.trailing
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: view)
            
            currentSelection = UIView()
            guard let selection = currentSelection else { return }
            
            selection.frame = CGRect(x: 0, y: location.y, width: 10, height: 10)
            selection.backgroundColor = .red
            selection.alpha = 0.5
            
            view.addSubview(selection)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: view)
            
            guard let selection = currentSelection else { return }
            let startLocation = selection.frame.origin
            
            selection.frame = CGRect(x: 0, y: startLocation.y, width: view.frame.width, height: location.y - startLocation.y)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let selection = currentSelection else { return }

        selections.append(selection)
        
        currentSelection = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let selection = currentSelection else { return }
        
        if selection.superview != nil {
            selection.removeFromSuperview()
        }
        currentSelection = nil
    }
}

