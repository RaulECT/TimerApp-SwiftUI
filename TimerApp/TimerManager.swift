//
//  TimerManager.swift
//  TimerApp
//
//  Created by Raul  Canul on 21/05/20.
//  Copyright © 2020 Raul  Canul. All rights reserved.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    // MARK: Variables
    @Published var timerMode: TimerMode = .initial
    @Published var secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
    var timer = Timer()
    
    // MARK: Functions
    func start() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            if self.secondsLeft == 0 {
                self.reset()
            }
            self.secondsLeft -= 1
        })
        
    }
    
    func reset() {
        timerMode = .initial
        secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
        timer.invalidate()
    }
    
    func pause() {
        timerMode = .paused
        timer.invalidate()
    }
    
    func setTimerLength(minutes: Int) {
        let defaults = UserDefaults.standard
        defaults.set(minutes, forKey: "timerLength")
        secondsLeft = minutes
    }
}
