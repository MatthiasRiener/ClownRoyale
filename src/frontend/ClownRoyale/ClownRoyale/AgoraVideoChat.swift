import SwiftUI
import AgoraUIKit

struct AgoraVideo: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = AgoraVideoViewController

    func makeUIViewController(context: Context) -> AgoraVideoViewController {
        AgoraVideoViewController(appID: "3bf64b431a4f4229b98b3e70082a0c17", channel: "pete")
    }

    func updateUIViewController(_ uiViewController: AgoraVideoViewController, context: Context) {

    }
}
