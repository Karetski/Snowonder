//
//  ImportCategoryTests.swift
//  Snowonder
//
//  Created by Aliaksei Karetski on 07.07.17.
//  Copyright © 2017 Karetski. All rights reserved.
//

import XCTest

@testable import ImportArtisan

class ImportCategoryTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testEquatable() {
        let importCategory00 = ImportCategory(title: "First", declarationPattern: "^import .*", sortingComparisonResult: .orderedAscending)
        let importCategory01 = ImportCategory(title: "First", declarationPattern: "^import .*", sortingComparisonResult: .orderedAscending)
        let importCategory1 = ImportCategory(title: "Second", declarationPattern: "^import .*", sortingComparisonResult: .orderedAscending)
        let importCategory2 = ImportCategory(title: "Third", declarationPattern: "^#import \".*\"", sortingComparisonResult: .orderedAscending)
        let importCategory3 = ImportCategory(title: "Fourth", declarationPattern: "^#import \".*\"", sortingComparisonResult: .orderedDescending)
        
        XCTAssertTrue(importCategory00 == importCategory01)
        XCTAssertFalse(importCategory00 == importCategory1)
        XCTAssertFalse(importCategory1 == importCategory2)
        XCTAssertFalse(importCategory2 == importCategory3)
    }

    func testHashable() {
        let importCategory00 = ImportCategory(title: "First", declarationPattern: "^import .*", sortingComparisonResult: .orderedAscending)
        let importCategory01 = ImportCategory(title: "First", declarationPattern: "^import .*", sortingComparisonResult: .orderedAscending)
        let importCategory1 = ImportCategory(title: "Second", declarationPattern: "^import .*", sortingComparisonResult: .orderedAscending)
        let importCategory2 = ImportCategory(title: "Third", declarationPattern: "^#import \".*\"", sortingComparisonResult: .orderedAscending)
        let importCategory3 = ImportCategory(title: "Fourth", declarationPattern: "^#import \".*\"", sortingComparisonResult: .orderedDescending)
        
        XCTAssertTrue(importCategory00.hashValue == importCategory01.hashValue)
        XCTAssertFalse(importCategory00.hashValue == importCategory1.hashValue)
        XCTAssertFalse(importCategory1.hashValue == importCategory2.hashValue)
        XCTAssertFalse(importCategory2.hashValue == importCategory3.hashValue)
        
        let constructingHash = "First".hashValue ^ "^import .*".hashValue ^ ComparisonResult.orderedAscending.hashValue
        let constructedHash = -8442284183870363690
        
        XCTAssertTrue(importCategory00.hashValue == constructingHash)
        XCTAssertTrue(importCategory00.hashValue == constructedHash)
    }
}
