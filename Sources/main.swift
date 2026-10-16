import Cadova
import Foundation

await Project(packageRelative: "Models") {
    await Model("qr-sign") {
        @Environment(\.buildDestination) var destination

        Metadata(
            title: "QR Code Sign",
            description: "A standing sign with a QR code for a Wi-Fi network or a web address, and an optional caption.",
            author: "Tomas Wincent Franzén",
            license: "MIT"
        )

        @Parameter("Width", in: 50...150, step: 1, unit: "mm")
        var width = 80.0

        @Parameter("Thickness", in: 1.5...8, step: 0.5, unit: "mm", description: "Thickness of the sign and its foot")
        var thickness = 4.0

        @Parameter("Angle", in: 60°...90°, step: 1°, description: "Angle between the sign and the surface it stands on")
        var angle = 75°

        @Parameter("Foot length", in: 20...80, step: 1, unit: "mm", description: "How far the foot reaches behind the sign")
        var footLength = 35.0

        @Parameter("Caption", description: "Text below the code. Leave it empty for none.")
        var caption = "Wi-Fi"

        @Parameter("Text size", in: 6...20, step: 0.5, unit: "mm", description: "Font size of the caption")
        var textSize = 10.0

        @Parameter("Code for", description: "What scanning the code does")
        var kind = QRContent.Kind.wifi

        let content: QRContent
        switch kind {
        case .wifi:
            @Parameter("Network name") var ssid = "Example Network"
            @Parameter("Password") var password = "mypassword"
            content = .wifi(ssid: ssid, password: password)
        case .url:
            @Parameter("Web address") var address = "https://example.com/"
            content = .url(URL(string: address) ?? URL(string: "https://example.com/")!)
        }

        let sign = QRSign(
            code: content,
            caption: caption.isEmpty ? nil : caption,
            frontSize: width,
            footAngle: angle,
            footDepth: footLength,
            textSize: textSize,
            thickness: thickness
        )

        // The sign prints face down, but the preview stands it up, facing the camera
        if destination == .customizerPreview {
            sign.rotated(x: 180° - angle).rotated(z: 180°)
        } else {
            sign
        }
    }
}
