//
//  Loader.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import "Loader.h"

@interface Loader ()

@property (nonatomic, strong) NSURL *url;

@end

@implementation Loader

- (instancetype)initWithURLString:(NSString *)urlString {
    self = [super init];
    
    if (self) {
        self.url = [NSURL URLWithString:urlString];
    }
    
    return self;
}

#pragma mark - Method to load data from url
- (void)loadNews:(void (^)(NSData *,
                           NSError *))completion {
    
    NSError *urlError = [[[NSError alloc]
                          initWithDomain:@"URL Error"
                          code:1
                          userInfo:nil]
                         autorelease];
    
    if (self.url == nil) {
        
        completion(nil, urlError);
        
    } else {
        
        NSError *loadError;
        NSData *data = [NSData dataWithContentsOfURL:self.url
                                             options:0
                                               error:&loadError];
        
        if (data == nil) {
            completion(nil, loadError);
        } else {
            completion(data, nil);
        }
    }
    
    
}

@end
