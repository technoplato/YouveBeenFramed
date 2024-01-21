import ReplayKit

class SampleHandler: RPBroadcastSampleHandler {
    private let sharedDefaults = UserDefaults(suiteName: "group.fram3duvbin.ios")

    private func logEvent(_ event: String) {
        print(event)
        var eventLog = sharedDefaults?.array(forKey: "eventLog") as? [String] ?? []
        eventLog.append("\(Date()): \(event)")
        sharedDefaults?.set(eventLog, forKey: "eventLog")
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
        logEvent("Received application info: \(applicationInfo)")
    }
    
    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        switch sampleBufferType {
        case RPSampleBufferType.video:
            logEvent("Processing video sample buffer")
            // Handle video sample buffer
            break
        case RPSampleBufferType.audioApp:
            logEvent("Processing app audio sample buffer")
            // Handle audio sample buffer for app audio
            break
        case RPSampleBufferType.audioMic:
            logEvent("Processing microphone audio sample buffer")
            // Handle audio sample buffer for mic audio
            break
        @unknown default:
            logEvent("Encountered unknown type of sample buffer")
            fatalError("Unknown type of sample buffer")
        }
    }
}
