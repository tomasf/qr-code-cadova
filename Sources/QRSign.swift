import Foundation
import Cadova

struct QRSign: Geometry3D {
    let code: QRContent
    let caption: String?
    var frontSize = 80.0
    var footAngle = 75°
    var footDepth = 35.0
    var textSize = 10.0
    var thickness = 4.0

    static let font = Bundle.module.url(forResource: "Fredoka", withExtension: "ttf")

    var body: any Geometry3D {
        let edgeMargin = 7.0
        let itemSpacing = 5.0
        let cornerRadius = 7.0

        let pixelDepth = 0.6

        let codeSize = frontSize - 2 * edgeMargin

        let stack: any Geometry2D = Stack(.y, spacing: itemSpacing, alignment: .centerX) {
            if let caption {
                Text(caption)
                    .withFont("Fredoka", size: textSize, from: Self.font)
                    .withFontVariations([.weight(550)])
            }

            QRBitmap(content: code)
                .aligned(at: .center)
                .resized(x: codeSize, y: codeSize, alignment: .center)
        }

        let solid = stack.aligned(at: .center)
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
                            .inPart(name: "Foreground", color: .black)
                    }
                    .aligned(at: .minY)
            }
            .subtracting {
                Box(frontSize)
                    .aligned(at: .centerX, .maxY)
                    .rotated(x: -90° + footAngle)
            }
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

        // Round the inside corner between the sign and its foot. The code's pockets are cut after
        // this, so this is the only concave edge.
        solid
            .shapingEdges(.fillet(radius: footDepth * 0.3), matching: .concave)
            .subtractingParts()
            .inPart(name: "Base", color: .white)
    }
}
