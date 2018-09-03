//
//  QuoteServiceTestCase.swift
//  ClassQuoteTests
//
//  Created by Mickael on 03/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//
@testable import ClassQuote
import XCTest

class QuoteServiceTestCase: XCTestCase {
    
    func testGetQuoteShouldPostFailedCallbackIfError() {
        
        // Given
        let quoteService = QuoteService(
            quoteSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData().error),
            imageSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        quoteService.getQuote { (success, quote) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(quote)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetQuoteShouldPostFailedCallbackIfNoData() {
        
        // Given
        let quoteService = QuoteService(
            quoteSession: URLSessionFake(data: nil, response: nil, error: nil),
            imageSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        quoteService.getQuote { (success, quote) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(quote)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetQuoteShouldPostFailedCallbackIfIncorrectResponse() {
        
        // Given
        let quoteService = QuoteService(
            quoteSession: URLSessionFake(data: FakeResponseData().quoteCorrectData, response: FakeResponseData().responseKO, error: nil),
            imageSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        quoteService.getQuote { (success, quote) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(quote)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetQuoteShouldPostFailedCallbackIfIncorrectData() {
        
        // Given
        let quoteService = QuoteService(
            quoteSession: URLSessionFake(data: FakeResponseData().quoteIncorrectData, response: FakeResponseData().responseOK, error: nil),
            imageSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        quoteService.getQuote { (success, quote) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(quote)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetQuoteShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        
        // Given
        let quoteService = QuoteService(
            quoteSession: URLSessionFake(data: FakeResponseData().quoteCorrectData, response: FakeResponseData().responseOK, error: nil),
            imageSession: URLSessionFake(data: FakeResponseData().imageData, response: FakeResponseData().responseOK, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        quoteService.getQuote { (success, quote) in
            //then
            let text = "There never was a good knife made of bad steel. "
            let author = "Benjamin Franklin"
            let iamge = "image".data(using: .utf8)!
            XCTAssertTrue(success)
            XCTAssertNotNil(quote)
            XCTAssertEqual(text, quote!.text)
            XCTAssertEqual(author, quote!.author)
            XCTAssertEqual(imageData, quote!.imageData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
