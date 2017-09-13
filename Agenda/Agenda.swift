//
//  Agenda.swift
//  Agenda
//
//  Created by Developer on 9/13/17.
//  Copyright © 2017 JwitApps. All rights reserved.
//

import Foundation

import Firebase

class Agenda {
    var events: [Event]
 
    init(events: [Event]) {
        self.events = events
    }
    
    init(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String : Any] else { fatalError() }
        
        self.events = value["events"] as! [Event]
    }
}

struct Event {
    let startTime: Float
    let endTime: Float
}
