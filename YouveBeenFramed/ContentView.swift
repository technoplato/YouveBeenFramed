//
//  ContentView.swift
//  YouveBeenFramed
//
//  Created by laptop on 1/20/24.
//

import SwiftUI
import ReplayKit

struct ContentView: View {
    var body: some View {
        VStack {
          Text("hi")
            EventLogView(viewModel: EventLogViewModel(appGroup: "group.fly.bye"))
          Button("Check Shared Events") {
            let sharedDefaults = UserDefaults(suiteName: "group.fly.bye")
            let eventLog = sharedDefaults?.array(forKey: "eventLog") as? [String] ?? []
            print(eventLog.count)
          }
        }
        .padding()
    }
}
import Foundation
import Combine

import Foundation
import Combine
class EventLogFilePresenter: NSObject, NSFilePresenter {
    let presentedItemURL: URL
    let presentedItemOperationQueue: OperationQueue = .main

    init(fileURL: URL) {
        presentedItemURL = fileURL
        super.init()
        NSFileCoordinator.addFilePresenter(self)
    }

    func presentedItemDidChange() {
        // Read the file and update your UI accordingly
        // You might want to post a notification or use some other method to update the UI
        print("File changed, update UI")
    }
}
class EventLogViewModel: ObservableObject {
    @Published var eventLog: [String] = []
    private let filePresenter: EventLogFilePresenter

    init() {
        let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.fram3duvbin.ios")!
        let fileURL = containerURL.appendingPathComponent("EventLog.txt")
        filePresenter = EventLogFilePresenter(fileURL: fileURL)
        
        filePresenter.onFileChange = { [weak self] in
            self?.loadEventLog()
        }
    }

    private func loadEventLog() {
        let fileURL = filePresenter.presentedItemURL
        if let fileContents = try? String(contentsOf: fileURL, encoding: .utf8) {
            DispatchQueue.main.async {
                self.eventLog = fileContents.components(separatedBy: .newlines)
                print("Loaded event log: \(self.eventLog)")
            }
        }
    }
}

struct EventLogView: View {
    @ObservedObject var viewModel: EventLogViewModel

    var body: some View {
        NavigationView {
            List(viewModel.eventLog, id: \.self) { logEntry in
                Text(logEntry)
            }
            .navigationBarTitle("Event Log")
        }
    }
}
