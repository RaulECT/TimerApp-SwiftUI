//
//  ContentView.swift
//  TimerApp
//
//  Created by Raul  Canul on 21/05/20.
//  Copyright © 2020 Raul  Canul. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // MARK: State variables
    @State var selectedPickerIndex = 0
    
    // MARK: Observable variables
    @ObservedObject var timerManager = TimerManager()
    
    // MARK: Variables
    let avaibleMinutes = Array(1...59)
    
    var body: some View {
        VStack {
            Text(secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))
                .font(.system(size: 80))
                .padding( .top, 80 )
            
            Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
                .foregroundColor(.orange)
                .onTapGesture(perform: {
                    if self.timerManager.timerMode == .initial {
                        self.timerManager.setTimerLength(minutes: self.avaibleMinutes[self.selectedPickerIndex]*60)
                    }
                    
                    self.timerManager.timerMode == .running ?
                        self.timerManager.pause() :
                        self.timerManager.start()
                })
            
            if timerManager.timerMode == .paused {
                Text("paused")
                Image(systemName: "gobackward")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding(.top, 40)
                    .onTapGesture(perform: {
                        self.timerManager.reset()
                    })
            }
            
            if timerManager.timerMode == .initial {
                Picker(selection: $selectedPickerIndex, label: Text("")) {
                    ForEach(0 ..< avaibleMinutes.count) {
                        Text("\(self.avaibleMinutes[$0]) min")
                    }
                }
                    .labelsHidden()
            }
            
            Spacer()
        }
            .navigationBarTitle("My timer")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
