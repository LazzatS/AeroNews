//
//  MockData.h
//  AeroNewsTests
//
//  Created by Lazzat Seiilova on 17.04.2022.
//

#import <Foundation/Foundation.h>

@interface MockData : NSObject

- (NSString *)getFilePath;
- (NSURL *)getMockFileURL;
- (NSData *)getMockData;
- (NSUInteger)getNumberOfItems;

@end
