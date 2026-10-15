import Cadova
import Foundation

await Project(packageRelative: "Models") {
    await Model("qr-sign") {
        Metadata(
            title: "QR Code Sign",
            description: "A standing sign with a QR code for a Wi-Fi network or a web address, and an optional caption."
        )

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

        @Parameter("Caption", description: "Text above the code. Leave it empty for none.")
        var caption = "Wi-Fi"

        @Parameter("Width", in: 50...150, step: 1, unit: "mm")
        var width = 80.0

        @Parameter("Angle", in: 60°...90°, step: 1°, description: "Angle between the sign and the surface it stands on")
        var angle = 75°

        QRSign(code: content, caption: caption.isEmpty ? nil : caption, frontSize: width, footAngle: angle)
            .rotated(x: 180° - angle)
    }
}
