//
//  NewsItemModel.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import "NewsItemModel.h"

@implementation NewsItemModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        NSDictionary *newsItem = dict[@"item"];
        _title = newsItem[@"title"];
        _link = newsItem[@"link"];
        _itemDescription = newsItem[@"description"];
        _pubDate = newsItem[@"pubDate"];
        _videoURL = newsItem[@"guid"];
        _enclosure = newsItem[@"enclosure"];
        _ImageURL = newsItem[@"itunes:image"];
    }
    
    return self;
}

@end
