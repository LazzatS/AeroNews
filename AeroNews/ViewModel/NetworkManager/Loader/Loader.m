//
//  Loader.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import "Loader.h"

@implementation Loader

#pragma mark - Method to load data from url

- (void)loadNewsFromURL:(NSURL *)url
             completion:(void (^)(NSData *,
                                  NSError *))completion {
    
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
