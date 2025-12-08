import Foundation
import Cadova
import CoreImage
import CoreImage.CIFilterBuiltins
import AppKit

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
    let correctionLevel: String

    init(content: QRContent, correctionLevel: String = "M") {
        self.content = content
        self.correctionLevel = correctionLevel
    }

    var body: any Geometry2D {
        let filter = CIFilter.qrCodeGenerator()
        filter.message = content.message.data(using: .utf8)!
        filter.correctionLevel = correctionLevel

        if let ciImage = filter.outputImage {
            let bitmap = NSBitmapImageRep(ciImage: ciImage)

            for x in 0..<Int(bitmap.size.width) {
                for y in 0..<Int(bitmap.size.height) {
                    let isSet = (bitmap.colorAt(x: x, y: y)?.brightnessComponent ?? 1.0) < 0.5
                    if isSet {
                        Rectangle(1)
                            .translated(x: Double(x), y: Double(y))
                    }
                }
            }
        }
    }
}
