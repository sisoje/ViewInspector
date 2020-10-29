import XCTest
import SwiftUI
@testable import ViewInspector

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
final class MenuTests: XCTestCase {
    
    func testExtractionFromSingleViewContainer() throws {
        let view = AnyView(Menu("abc", content: { EmptyView() }))
        XCTAssertNoThrow(try view.inspect().anyView().menu())
    }
    
    func testExtractionFromMultipleViewContainer() throws {
        let view = HStack {
            Text("")
            Menu("abc", content: { EmptyView() })
            Text("")
        }
        XCTAssertNoThrow(try view.inspect().hStack().menu(1))
    }
    
    func testLabelInspection() throws {
        let view = Menu(content: {
            HStack { Text("abc") }
        }, label: {
            VStack { Text("xyz") }
        })
        let sut = try view.inspect().menu().label().vStack().text(0).string()
        XCTAssertEqual(sut, "xyz")
    }
    
    func testContentInspection() throws {
        let view = Menu(content: {
            HStack { Text("abc") }
        }, label: {
            VStack { Text("xyz") }
        })
        let sut = try view.inspect().menu().hStack(0).text(0).string()
        XCTAssertEqual(sut, "abc")
    }
}
