//
//  MockData.m
//  AeroNewsTests
//
//  Created by Lazzat Seiilova on 17.04.2022.
//

#import "MockData.h"

@implementation MockData

- (NSString *)getFilePath {
    return [[NSBundle mainBundle]
            pathForResource:@"MockData"
            ofType:@"xml"];
}

- (NSURL *)getMockFileURL {
    NSString *path = [self getFilePath];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    return fileURL;
}

- (NSData *)getMockData {
    NSURL *url = [self getMockFileURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
}

- (NSUInteger)getNumberOfItems {
    NSString *stringFromData = [[[NSString alloc]
                                 initWithData:[self getMockData]
                                 encoding:NSUTF8StringEncoding]
                                autorelease];
    
    NSArray *arrayOfXMLItems = [stringFromData componentsSeparatedByString:@"<item>"];
    NSMutableArray *arrayOfNewsItems = [[[NSMutableArray alloc]
                            initWithArray:arrayOfXMLItems]
                           autorelease];
    
    [arrayOfNewsItems removeObjectAtIndex:0];           // remove xml file description
    return arrayOfNewsItems.count;
}

@end
