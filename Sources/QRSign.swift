import Foundation
import Cadova

struct QRSign: Shape3D {
    let code: QRContent
    let caption: String?

    var body: any Geometry3D {
        let frontSize = 80.0
        let thickness = 3.0
        let edgeMargin = 7.0
        let itemSpacing = 5.0
        let cornerRadius = 7.0

        let footDepth = 35.0
        let footAngle = 75°
        let pixelDepth = 0.6

        let codeSize = frontSize - 2 * edgeMargin

        Stack(.y, spacing: itemSpacing, alignment: .centerX) {
            if let caption {
                Text(caption)
                    .withFont("SF Pro Rounded", style: "Bold", size: 10)
            }

            QRBitmap(content: code)
                .aligned(at: .center)
                .resized(x: codeSize, y: codeSize, alignment: .center)
        }
        .aligned(at: .center)
        .measuringBounds { content, bounds in
            let ySize = bounds.size.y + 2 * edgeMargin
            Rectangle(x: frontSize, y: ySize)
                .aligned(at: .center)
                .cuttingEdgeProfile(.fillet(radius: cornerRadius), on: .top)
                .extruded(height: thickness)
                .adding {
                    content
                        .flipped(along: .x)
                        .extruded(height: pixelDepth)
                        .colored(.black)
                        .inPart(named: "Foreground")
                }
                .aligned(at: .minY)
        }
        .subtracting {
            Box(frontSize)
                .aligned(at: .centerX, .maxY)
                .rotated(x: -90° + footAngle)
        }
        .subtractingParts()
        .adding {
            let yExtension = thickness
            Rectangle(x: frontSize, y: footDepth + yExtension)
                .cuttingEdgeProfile(.fillet(radius: cornerRadius), on: .top)
                .aligned(at: .centerX)
                .translated(y: -yExtension)
                .extruded(height: thickness)
                .aligned(at: .top)
                .rotated(x: footAngle)
                .within(z: 0...)
        }
        .inPart(named: "Base")
    }
}
