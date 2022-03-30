import XCTest
@testable import KKKit
import SwiftUI

final class KKKitTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(KKKit().text, "Hello, World!")
    }
    
    func testStringToImage() throws {
        let image = "Test".image()
        XCTAssertNotNil(image)
    }
    
    func testHexToColor() throws {
        let color = Color(hex: 0x255AA6)
        XCTAssertNotNil(color)
    }
}
