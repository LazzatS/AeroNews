//
//  AeroNewsTests.m
//  AeroNewsTests
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import <XCTest/XCTest.h>
#import "MockData.h"
#import "Loader.h"
#import "XMLParser.h"
#import "NetworkLayer.h"
#import "ViewModel.h"

@interface AeroNewsTests : XCTestCase

@end

@implementation AeroNewsTests

- (void)setUp {
    NSLog(@"------- Start Test -------");
}

- (void)tearDown {
    NSLog(@"------- Finish Test -------");
}

- (void)testLoaderDataIsNotNil {
    // given
    MockData *mockData = [[MockData new] autorelease];
    Loader *loader = [[Loader new] autorelease];
    
    // when
    [loader loadNewsFromURL:[mockData getMockFileURL]
                 completion:^(NSData *mockData, NSError *mockError) {
        // then
        XCTAssertNotNil(mockData);
        XCTAssertNil(mockError);
    }];
}

- (void)testParserDataIsNotNil {
    // given
    MockData *mockData = [[MockData new] autorelease];
    XMLParser *parser = [[XMLParser new] autorelease];
    
    // when
    [parser parseNews:[mockData getMockData]
           completion:^(NSArray<ItemModel *> *data,
                        NSError *error) {
        
        // then
        XCTAssertNotNil(data);
        XCTAssertNil(error);
    }];
}

- (void)testSizeOfLoadedBytesEqualToSizeOfParsedBytes {
    // given
    MockData *mockData = [[MockData new] autorelease];
    __block NSUInteger expectedSizeOfItems;
    Loader *loader = [[Loader new] autorelease];
    XMLParser *parser = [[XMLParser new] autorelease];
    
    // when
    [loader loadNewsFromURL:[mockData getMockFileURL]
                 completion:^(NSData *data, NSError *error) {
        expectedSizeOfItems = sizeof(data);
    }];
    
    [parser parseNews:[mockData getMockData]
           completion:^(NSArray<ItemModel *> *array,
                        NSError *error) {
        
        // then
        XCTAssertEqual(expectedSizeOfItems, sizeof(array));
        
    }];
}

- (void)testNumberOfFetchedItems {
    // given
    MockData *mockData = [[MockData new] autorelease];
    Loader *loader = [[Loader new] autorelease];
    XMLParser *parser = [[XMLParser new] autorelease];
    NetworkLayer *networkLayer = [[[NetworkLayer alloc]
                                   initWithLoader:loader
                                   andParser:parser]
                                  autorelease];
    NSUInteger expectedNumberOfItems = [mockData getNumberOfItems];
    
    // when
    [networkLayer fetchNewsFromURL:[mockData getMockFileURL]
                       withSuccess:^(NSArray<ItemModel *> *array) {
        
        // then
        XCTAssertEqual(expectedNumberOfItems, array.count);
        
    } withError:^(NSError *error) {
        
        // then
        XCTAssertNil(error);
    }];
}

- (void)testViewModel {
    // given
    MockData *mockData = [[MockData new] autorelease];
    ViewModel *viewModel = [[ViewModel new] autorelease];
    XCTestExpectation *expectation = [self expectationWithDescription:@"complete"];
    
    // when
    [viewModel getNewsFromURL:[mockData getMockFileURL]
                      success:^(NSArray<ItemModel *> *array) {
        
        // either then
        XCTAssertEqual([mockData getNumberOfItems], array.count);
        XCTAssertEqual([viewModel numberOfNewsItems], array.count);
        XCTAssertEqual([viewModel newsItemAtIndexPath:0], array.firstObject);
        [expectation fulfill];
        
    } error:^(NSError *error) {
        
        // or then
        XCTAssertNotNil(error);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectations:@[expectation] timeout:15];
}

@end
