//
//  ContentView.swift
//  Stopwatch_iOS
//
//  Created by Sambit Das on 30/08/23.
//

import SwiftUI

struct ContentView: View {

  @State var isRunning: Bool = false
  @State var timerElapsed: TimeInterval = 0
  private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

  var body: some View {
    VStack(alignment: .center, spacing: 32) {
      Image(systemName: "stopwatch")
        .resizable()
        .imageScale(.large)
        .frame(width: 55, height: 58)
        .foregroundStyle(.tint)
        Text("\(timeString(time: timerElapsed))")
          .font(.largeTitle)
          .fontWeight(.black)
      HStack(spacing: 24) {
        resetButton
        startAndStopButton
      }
    }
    .padding(.all, 24)
    .onReceive(timer) { _ in
      if self.isRunning {
        self.timerElapsed += 0.1
      }
    }
  }

  private var resetButton: some View {
    Button {
      resetTimer()
    } label: {
      HStack {
        Image(systemName: "arrow.clockwise")
          .imageScale(.large)
          .foregroundStyle(.white)
        Text("Reset")
          .foregroundStyle(.white)
          .fontWeight(.semibold)
          .font(.title)
          .frame(maxWidth: .infinity)
      }
      .padding()
    }
    .background(Color.red)
    .clipShape(.capsule)
  }

  private var startAndStopButton: some View {
    Button {
      if isRunning {
        stopTimer()
      } else {
        startTimer()
      }
    } label: {
      HStack(spacing: 8) {
        Image(systemName: isRunning ? "pause.fill" : "play.fill")
          .imageScale(.large)
          .foregroundStyle(.white)
        Text(isRunning ? "Stop" : "Start")
          .foregroundStyle(.white)
          .fontWeight(.semibold)
          .font(.title)
          .frame(maxWidth: .infinity)
      }
      .padding()
    }
    .background(isRunning ? Color.red : Color.green)
    .clipShape(.capsule)
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
  }

  private func timeString(time: TimeInterval) -> String {
    let minutes = Int(time) / 60
    let seconds = Int(time) % 60
    let miliseconds = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
    return String(format: "%02d.%02d:%02d", minutes, seconds, miliseconds)
  }
}

#Preview {
  ContentView(isRunning: true)
}
