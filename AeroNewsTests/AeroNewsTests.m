//
//  AeroNewsTests.m
//  AeroNewsTests
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import <XCTest/XCTest.h>
#import "MockData.h"
#import "NewsLoader.h"
#import "NewsXMLParser.h"
#import "NewsFetcher.h"
#import "NewsViewModel.h"

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
    [loader loadNews:^(NSData *mockData, NSError *mockError) {
        
        // then
        XCTAssertNotNil(mockData);
        XCTAssertNil(mockError);
        
    } from:[mockData getMockFileURL]];
}

- (void)testParserDataIsNotNil {
    // given
    MockData *mockData = [[MockData new] autorelease];
    NewsXMLParser *parser = [[NewsXMLParser new] autorelease];
    
    // when
    [parser parseNews:[mockData getMockData]
           completion:^(NSArray<NewsItemModel *> *data,
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
    NewsXMLParser *parser = [[NewsXMLParser new] autorelease];
    
    // when
    [loader loadNews:^(NSData *data, NSError *error) {
        expectedSizeOfItems = sizeof(data);
    } from:[mockData getMockFileURL]];
    
    [parser parseNews:[mockData getMockData]
           completion:^(NSArray<NewsItemModel *> *array,
                        NSError *error) {
        
        // then
        XCTAssertEqual(expectedSizeOfItems, sizeof(array));
        
    }];
}

- (void)testNumberOfFetchedItems {
    // given
    MockData *mockData = [[MockData new] autorelease];
    Loader *loader = [[Loader new] autorelease];
    NewsXMLParser *parser = [[NewsXMLParser new] autorelease];
    NewsFetcher *newsFetcher = [[[NewsFetcher alloc]
                                 initWithLoader:loader
                                 andParser:parser]
                                autorelease];
    NSUInteger expectedNumberOfItems = [mockData getNumberOfItems];
    
    // when
    [newsFetcher fetchNews:^(NSArray<NewsItemModel *> *array, NSError *error) {
        
        // then
        XCTAssertEqual(expectedNumberOfItems, array.count);
        
    } fromURL:[mockData getMockFileURL]];
}

- (void)testViewModel {
    // given
    MockData *mockData = [[MockData new] autorelease];
    NewsViewModel *viewModel = [[NewsViewModel new] autorelease];
    XCTestExpectation *expectation = [self expectationWithDescription:@"complete"];
    
    // when
    [viewModel getNewsWithSuccess:^(NSArray<ItemModel *> *array) {
        
        // either then
        XCTAssertEqual([mockData getNumberOfItems], array.count);
        XCTAssertEqual([viewModel numberOfNewsItems], array.count);
        XCTAssertEqual([viewModel newsItemAtIndexPath:0], array.firstObject);
        [expectation fulfill];
        
    } error:^(NSError *error) {
        
        // or then
        XCTAssertNotNil(error);
        [expectation fulfill];
        
    } fromURL:[mockData getMockFileURL]];
    
    [self waitForExpectations:@[expectation] timeout:15];
}

@end
