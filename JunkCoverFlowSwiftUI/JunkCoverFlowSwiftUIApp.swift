//
//  JunkCoverFlowSwiftUIApp.swift
//  JunkCoverFlowSwiftUI
//
//  Created by Nicky Taylor on 10/1/24.
//

import SwiftUI

@main
struct JunkCoverFlowSwiftUIApp: App {
    let controller = Controller()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(controller)
        }
    }
}
