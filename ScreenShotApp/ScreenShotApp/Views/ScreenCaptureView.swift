//
//  ContentView.swift
//  ScreenShotApp
//
//  Created by GOURAVM on 06/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var image: NSImage? = nil
    var body: some View {
        VStack {
            if let image {
                Image(nsImage: image)
            }
            Button("Make a Screenshot") {
                let task = Process()
                task.executableURL = URL(fileURLWithPath: "/usr/sbin/screencapture")
                task.arguments = ["-cw"]
                do {
                    try task.run()
                    task.waitUntilExit()
                } catch {
                    print("Could not take screenshot")
                }
                
                guard NSPasteboard.general.canReadItem(withDataConformingToTypes: NSImage.imageTypes) else { return }
                
                guard let image = NSImage(pasteboard: NSPasteboard.general) else { return }
                
                self.image = image
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
