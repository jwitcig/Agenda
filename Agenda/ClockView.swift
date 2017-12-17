//
//  ClockView.swift
//  Agenda
//
//  Created by Developer on 9/17/17.
//  Copyright © 2017 JwitApps. All rights reserved.
//

import UIKit

class ClockView : UIStackView {
    
    let timeViews: [UIView]
    
    init() {
        let clockTimes = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
        let times = clockTimes + clockTimes // AM and PM
        
        timeViews = times.enumerated().map {
            let label = UILabel(frame: .zero)
            label.text = $0 < 12 ? "\($1) am" : "\($1) pm"
            label.textColor = .white
            return label
        }
        
        super.init(frame: .zero)
        
        backgroundColor = .red
        
        axis = .vertical
        alignment = .fill
        distribution = .fillEqually
        
        timeViews.forEach(addArrangedSubview)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AgendaView : UIView {
    let clockView = ClockView()
    
    var eventInEdit: Agenda?
    private var eventInEditView: UIView?
    
    var agenda: Agenda {
        didSet {
            show(events: agenda.events)
        }
    }
    
    var events: [Event] {
        return agenda.events
    }
    
    init(agenda: Agenda) {
        self.agenda = agenda
        
        super.init(frame: .zero)
        
        backgroundColor = .gray
        
        addSubview(clockView)
        
        show(events: agenda.events)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func show(event: Event) {
        let view = eventView(fromTime: event.startTime, toTime: event.endTime)
        addSubview(view)
    }
    
    private func show(events: [Event]) {
        events.forEach(show)
    }
    
    private func eventView( fromTime startTime: Float, toTime endTime: Float) -> UIView {
        let startLocation = clockView.timeViews[Int(floor(startTime))].center.y
        let endLocation = clockView.timeViews[Int(floor(endTime))].center.y
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: startLocation, width: frame.width, height: endLocation - startLocation)
        view.backgroundColor = .red
        view.alpha = 0.5
        return view
    }
    
    func drawNewEvent(fromTime startTime: Float, toTime endTime: Float) {
        let event = Event(startTime: startTime, endTime: endTime)
        let view = eventInEditView ?? UIView()
        
        
        
        eventInEdit = event
    }
}


