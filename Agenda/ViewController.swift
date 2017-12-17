//
//  ViewController.swift
//  Agenda
//
//  Created by Developer on 9/12/17.
//  Copyright © 2017 JwitApps. All rights reserved.
//

import UIKit

import Cartography
import FirebaseDatabase

let username = ""

class ViewController: UIViewController {
    
    var selections: [UIView] = []
    var currentSelection: UIView?
    
    var agenda: Agenda?
    var agendaView: AgendaView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let event = Event(startTime: 1.4, endTime: 4)
        let agenda = Agenda(events: [event])
        show(agenda: agenda)
    }
    
    func show(agenda: Agenda) {
        if let existing = self.agendaView {
            existing.removeSafelyFromSuperview()
        }
        
        let agendaView = AgendaView(agenda: agenda)
        
        view.addSubview(agendaView)
    
        self.agendaView = agendaView
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

