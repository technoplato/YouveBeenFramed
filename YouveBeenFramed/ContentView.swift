//
//  ContentView.swift
//  YouveBeenFramed
//
//  Created by laptop on 1/20/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      VStack {
          OpenedAppsView(viewModel: OpenedAppsViewModel(appGroup: "group.fram3duvbin.ios"))
      }
        .padding()
    }
}

#Preview {
    ContentView()
}

import Foundation
import Combine

class OpenedAppsViewModel: ObservableObject {
    @Published var openedApps: [String] = []

    private var cancellables = Set<AnyCancellable>()
    private let userDefaults: UserDefaults

    init(appGroup: String) {
        guard let userDefaults = UserDefaults(suiteName: appGroup) else {
            fatalError("Could not initialize UserDefaults with app group: \(appGroup)")
        }
        self.userDefaults = userDefaults

        // Observing the changes in UserDefaults
        userDefaults
            .publisher(for: \.openedAppsKey, options: [.initial, .new])
            .compactMap { $0 }
            
            .assign(to: &$openedApps)
    }
}

struct OpenedAppsView: View {
    @ObservedObject var viewModel: OpenedAppsViewModel

    var body: some View {
        NavigationView {
            List(viewModel.openedApps, id: \.self) { app in
                Text(app)
            }
            .navigationBarTitle("Opened Applications")
        }
    }
}

extension UserDefaults {
    @objc dynamic var openedAppsKey: [String]? {
        return array(forKey: "openedApps") as? [String]
    }
}
