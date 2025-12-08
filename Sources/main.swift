import Cadova
import Foundation

await Project {
    await Model("Example Network") {
        QRSign(code: .wifi(ssid: "Example Network", password: "mypassword"), caption: "Wi-Fi")
    }
    await Model("Example.com") {
        QRSign(code: .url(URL(string: "https://example.com/")!), caption: nil)
    }
}
