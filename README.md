# qr-code-cadova
<img width="250" height="304" alt="image" src="https://github.com/user-attachments/assets/00ccc59d-cbe4-4901-aaa8-eacaf74a786e" align="right" />

A small Swift package that uses [Cadova](https://github.com/tomasf/Cadova) to procedurally generate 3D printable models of QR code signs with an optional caption and a tilted base/foot for display. The resulting 3MF file has separate parts for the sign itself and the pixels, so they're easy to assign to different colors in the slicer.

Try it in your browser with the [web customizer](https://tomasf.github.io/qr-code-cadova/), where you can set the code, caption and size and download a ready-to-print 3MF file.

QR code generation is handled via [SwiftQR](https://github.com/CorvidLabs/swift-qr).
