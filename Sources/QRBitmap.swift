import Foundation
import Cadova
import SwiftQR

enum QRContent {
    case url (URL)
    case wifi (ssid: String, password: String)

    var message: String {
        switch self {
        case .url (let url):
            url.absoluteString
        case .wifi (let ssid, let password):
            "WIFI:S:\(ssid);T:WPA;P:\(password);;"
        }
    }
}

struct QRBitmap: Shape2D, @unchecked Sendable {
    let content: QRContent
    let correctionLevel: QRErrorCorrectionLevel

    init(content: QRContent, correctionLevel: QRErrorCorrectionLevel = .medium) {
        self.content = content
        self.correctionLevel = correctionLevel
    }

    var body: any Geometry2D {
        if let qrCode = try? QRCode.encode(content.message, errorCorrection: correctionLevel) {
            for x in 0..<qrCode.size {
                for y in 0..<qrCode.size {
                    if qrCode.module(at: x, y: y) {
                        Rectangle(1)
                            .translated(x: Double(x), y: Double(y))
                    }
                }
            }
        }
    }
}
