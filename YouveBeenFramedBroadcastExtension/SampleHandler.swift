import ReplayKit

class SampleHandler: RPBroadcastSampleHandler {
  private let sharedFileURL: URL

  init() {
      if let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.fram3duvbin.ios") {
          sharedFileURL = containerURL.appendingPathComponent("EventLog.txt")
      } else {
          fatalError("Shared container not available")
      }
  }

  private func logEvent(_ event: String) {
      let fileCoordinator = NSFileCoordinator()
      var newEventLog = "\(Date()): \(event)\n"
      
      fileCoordinator.coordinate(writingItemAt: sharedFileURL, options: .forMerging, error: nil) { (url) in
          if let fileHandle = try? FileHandle(forWritingTo: url) {
              fileHandle.seekToEndOfFile()
              if let data = newEventLog.data(using: .utf8) {
                  fileHandle.write(data)
              }
              fileHandle.closeFile()
          } else {
              try? newEventLog.write(to: url, atomically: true, encoding: .utf8)
          }
      }
  }
  
  
    override func broadcastStarted(withSetupInfo setupInfo: [String : NSObject]?) {
        logEvent("Broadcast started - Setup Info: \(String(describing: setupInfo))")
    }
    
    override func broadcastPaused() {
        logEvent("Broadcast paused")
    }
    
    override func broadcastResumed() {
        logEvent("Broadcast resumed")
    }
    
    override func broadcastFinished() {
        logEvent("Broadcast finished")
    }
    
    override func broadcastAnnotated(withApplicationInfo applicationInfo: [AnyHashable : Any]) {
        if let applicationName = applicationInfo["UIApplicationOpenURLOptionUniversalLinksOnly"] as? String {
            logEvent("Application opened: \(applicationName)")
        } else {
            logEvent("Received application info: \(applicationInfo)")
        }
    }
    
    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        switch sampleBufferType {
        case RPSampleBufferType.video:
//            logEvent("Processing video sample buffer")
            // Handle video sample buffer
            break
        case RPSampleBufferType.audioApp:
//            logEvent("Processing app audio sample buffer")
            // Handle audio sample buffer for app audio
            break
        case RPSampleBufferType.audioMic:
//            logEvent("Processing microphone audio sample buffer")
            // Handle audio sample buffer for mic audio
            break
        @unknown default:
//            logEvent("Encountered unknown type of sample buffer")
            fatalError("Unknown type of sample buffer")
        }
    }
}
