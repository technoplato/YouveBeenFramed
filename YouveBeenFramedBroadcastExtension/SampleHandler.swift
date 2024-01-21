//
//  SampleHandler.swift
//  YouveBeenFramedBroadcastExtension
//
//  Created by laptop on 1/20/24.
//

import ReplayKit

class SampleHandler: RPBroadcastSampleHandler {
  
  override func broadcastAnnotated(withApplicationInfo applicationInfo: [AnyHashable : Any]) {
      // Handle the application info
      if let appInfo = applicationInfo as? [String: Any] {
          print("Received app info: \(appInfo)")
      }
  }

    override func broadcastStarted(withSetupInfo setupInfo: [String : NSObject]?) {
        // User has requested to start the broadcast. Setup info from the UI extension can be supplied but optional.
      print("broadcastStarted")
    }
    
    override func broadcastPaused() {
        // User has requested to pause the broadcast. Samples will stop being delivered.
      print("broadcastPaused")
    }
    
    override func broadcastResumed() {
        // User has requested to resume the broadcast. Samples delivery will resume.
      print("broadcastResumed")
    }
    
    override func broadcastFinished() {
      print("broadcastFinished")
        // User has requested to finish the broadcast.
    }
    
    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        switch sampleBufferType {
        case RPSampleBufferType.video:
            // Handle video sample buffer
            break
        case RPSampleBufferType.audioApp:
            // Handle audio sample buffer for app audio
            break
        case RPSampleBufferType.audioMic:
            // Handle audio sample buffer for mic audio
            break
        @unknown default:
            // Handle other sample buffer types
            fatalError("Unknown type of sample buffer")
        }
    }
}
