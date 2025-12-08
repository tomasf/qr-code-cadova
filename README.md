# QRSign Model

A small Swift package that uses [Cadova](https://github.com/tomasf/Cadova) to procedurally generate 3D printable models of QR code signs with an optional caption and a tilted base/foot for display. The resulting 3MF file has separate parts for the sign itself and the pixels, so they're easy to assign to different colors in the slicer.

QR code generation is handled via Core Image, so the package currently supports macOS only.
