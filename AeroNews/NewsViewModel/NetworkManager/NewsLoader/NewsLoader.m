//
//  NewsLoader.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import "NewsLoader.h"

#pragma mark - URL
static NSString *urlString = @"https://www.jpl.nasa.gov/feeds/news";

@implementation NewsLoader

#pragma mark - Method to load data from url
- (void)loadNews:(void (^)(NSData *, NSError *))completion {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    completion(data, nil);
}

@end
