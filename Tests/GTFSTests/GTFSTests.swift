import XCTest
@testable import GTFS

final class GTFSTests: XCTestCase {
    func testGTFSInit() throws {
        let _ = try! GTFS(path: "/Users/emma/Projects/rail-gtfs-static")
        
    }
}
