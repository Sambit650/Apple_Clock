//
//  ContentView.swift
//  Stopwatch_iOS
//
//  Created by Sambit Das on 30/08/23.
//

import SwiftUI

struct LapData {
  let index: String
  let value: String
}

struct ContentView: View {

  @State var isRunning: Bool = false
  @State var timerElapsed: TimeInterval = 0
  @State var laps: [LapData] = []
  private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

  var body: some View {
    VStack {
      Text("\(timeString(time: timerElapsed))")
        .font(.system(size: 78))
        .fontWeight(.light)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 80)
      HStack {
        resetButton
        Spacer()
        startAndStopButton
      }
      ScrollView {
        Divider()
        ForEach(laps, id: \.index) { lap in
          HStack {
            Text(lap.index)
            Spacer()
            Text(lap.value)
          }
          Divider()
        }
      }
    }
    .padding(.horizontal, 16)
    .onReceive(timer) { _ in
      if self.isRunning {
        self.timerElapsed += 0.1
      }
    }
  }

  private var resetButton: some View {
    ZStack {
      Circle()
        .frame(width: 80, height: 80)
        .foregroundColor(Color.gray.opacity(0.4))

      Text(isRunning ? "Lap" : "Reset")
        .fontWeight(.semibold)
        .font(.headline)
        .foregroundColor(.white)
    }
    .onTapGesture {
      if isRunning {
        lapTimer()
      } else {
        resetTimer()
      }
    }
  }

  private var startAndStopButton: some View {
    ZStack {
      Circle()
        .frame(width: 80, height: 80)
        .foregroundColor(isRunning ? Color.red.opacity(0.3) : Color.green.opacity(0.3))

      Text(isRunning ? "Stop" : "Start")
        .fontWeight(.semibold)
        .font(.headline)
        .foregroundColor(isRunning ? Color.red : Color.green)
    }
    .onTapGesture {
      if isRunning {
        stopTimer()
      } else {
        startTimer()
      }
    }
  }

  private func startTimer() {
    isRunning = true
  }

  private func stopTimer() {
    isRunning = false
  }

  private func resetTimer() {
    isRunning = false
    timerElapsed = 0
    laps.removeAll()
  }

  private func lapTimer() {
    laps.insert(LapData(index: "Lap \(laps.count+1)", value: timeString(time: timerElapsed)), at: 0)
  }

  private func timeString(time: TimeInterval) -> String {
    let minutes = Int(time) / 60
    let seconds = Int(time) % 60
    let miliseconds = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
    return String(format: "%02d:%02d.%02d", minutes, seconds, miliseconds)
  }
}

#Preview {
  ContentView(isRunning: true)
}
