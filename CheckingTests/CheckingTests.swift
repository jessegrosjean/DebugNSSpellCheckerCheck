import XCTest
@testable import Checking

final class CheckingTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testRequestChecking() async throws {
        let results = try await withCheckedThrowingContinuation { continuation in
            NSSpellChecker.shared.requestChecking(
                of: "teh",
                range: .init(0..<1),
                types: NSTextCheckingAllTypes,
                //options: <#T##[NSSpellChecker.OptionKey : Any]?#>,
                inSpellDocumentWithTag: 0) { _, results, _, _ in
                    continuation.resume(returning: results)
                }
        }
        print(results)

        
        //let results = try await withCheckedThrowingContinuation { continuation in
        //    NSSpellChecker.shared.requestChecking(forSelectedRange: .init(3..<3), in: "teh", types: NSTextCheckingAllTypes, inSpellDocumentWithTag: 0) { _, results in
//                continuation.resume(returning: results)
//            }
//        }
//        print(results)
    }

    func testRequestCandidates() async throws {
        let results = try await withCheckedThrowingContinuation { continuation in
            NSSpellChecker.shared.requestCandidates(forSelectedRange: .init(3..<3), in: "teh", types: NSTextCheckingAllTypes, inSpellDocumentWithTag: 0) { _, results in
                continuation.resume(returning: results)
            }
        }
        print(results)
    }

    
    func tryIt(_ string: String, tag: Int? = nil) {
        let types: NSTextCheckingResult.CheckingType = .allTypes
        let range = NSRange(location: 0, length: string.utf16.count)
        
        let r = NSSpellChecker.shared.check(
            string,
            range: range,
            types: types.rawValue,
            inSpellDocumentWithTag: 0,
            orthography: nil,
            wordCount: nil
        )
        
        print(r)
    }

}
