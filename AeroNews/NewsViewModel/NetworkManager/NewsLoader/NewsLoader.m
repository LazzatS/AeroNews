//
//  NewsLoader.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import "NewsLoader.h"

@implementation NewsLoader

#pragma mark - Method to load data from url
- (void)loadNews:(void (^)(NSData *, NSError *))completion from: (NSURL *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSError *loadError;
    NSData *data = [NSData dataWithContentsOfURL:url
                                         options:0
                                           error:&loadError];
    if (data == nil) {
        completion(nil, loadError);
    } else {
        completion(data, nil);
    }
    
}

@end
