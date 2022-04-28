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

@property (nonatomic, retain) MockData *mockData;

@end

@implementation AeroNewsTests

- (void)setUp {
    NSLog(@"------- Start Test -------");
    self.mockData = [[MockData new] autorelease];           // recall to stub !!!!!!!!!!!!!
}

- (void)tearDown {
    NSLog(@"------- Finish Test -------");
}

- (void)testLoaderDataIsNotNil {
    // given
    Loader *loader = [[Loader new] autorelease];
    // create method to return nil inside MockData
    
    // when
    [loader loadNewsFromURL:[self.mockData getMockFileURL]
                 completion:^(NSData *mockData, NSError *mockError) {
        
        // then
        XCTAssertNotNil(mockData);
        XCTAssertNil(mockError);
    }];
}

- (void)testParserDataIsNotNil {
    // given
    XMLParser *parser = [[XMLParser new] autorelease];
    
    // when
    [parser parseNews:[self.mockData getMockData]
           completion:^(NSArray<ItemModel *> *data,
                        NSError *error) {
        
        // then
        XCTAssertNotNil(data);
        XCTAssertNil(error);
    }];
}

- (void)testSizeOfLoadedBytesEqualToSizeOfParsedBytes {
    // given
    __block NSUInteger expectedSizeOfItems;
    Loader *loader = [[Loader new] autorelease];
    XMLParser *parser = [[XMLParser new] autorelease];
    
    // when
    [loader loadNewsFromURL:[self.mockData getMockFileURL]
                 completion:^(NSData *data, NSError *error) {
        expectedSizeOfItems = sizeof(data);
    }];
    
    [parser parseNews:[self.mockData getMockData]
           completion:^(NSArray<ItemModel *> *array,
                        NSError *error) {
        
        // then
        XCTAssertEqual(expectedSizeOfItems, sizeof(array));
        
    }];
}

- (void)testNumberOfFetchedItems {
    // given
    Loader *loader = [[Loader new] autorelease];
    XMLParser *parser = [[XMLParser new] autorelease];
    NetworkLayer *networkLayer = [[[NetworkLayer alloc]
                                   initWithLoader:loader
                                   andParser:parser]
                                  autorelease];
    NSUInteger expectedNumberOfItems = [self.mockData getNumberOfItems];
    
    // when
    [networkLayer fetchNewsFromURL:[self.mockData getMockFileURL]
                       withSuccess:^(NSArray<ItemModel *> *array) {
        
        // then
        XCTAssertEqual(expectedNumberOfItems, array.count);
        
    } withError:^(NSError *error) {
        
        // then
        XCTAssertNil(error);
    }];
}

- (void)testViewModelWithSuccess {
    // given
    Loader *loader = [[Loader new] autorelease];            // mockLoader
    XMLParser *parser = [[XMLParser new] autorelease];      // mockParser
    
    NetworkLayer *networkLayer = [[NetworkLayer alloc] initWithLoader:loader        // mockNetworkLayer (mock == perfect)
                                                            andParser:parser];
    ViewModel *viewModel = [[[ViewModel alloc] initWithNetworkLayer:networkLayer] autorelease];
    
    XCTestExpectation *expectationSuccess = [self expectationWithDescription:@"completeSuccess"];
    
    // when
    [viewModel getNewsFromURL:[self.mockData getMockFileURL]
                      success:^(NSArray<ItemModel *> *array) {
        
        // either then
        XCTAssertEqual([self.mockData getNumberOfItems], array.count);
        XCTAssertEqual([viewModel numberOfNewsItems], array.count);
        XCTAssertEqual([viewModel newsItemAtIndexPath:0], array.firstObject);
        [expectationSuccess fulfill];
        
    } error:^(NSError *error) {
        
        // or then
        XCTFail(@"AAAAAAAAAAAAAAAA");
        
    }];
    
    [self waitForExpectations:@[expectationSuccess] timeout:2];
}

@end
