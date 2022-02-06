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
        _title = dict[@"title"];
        _link = dict[@"link"];
        _itemDescription = dict[@"description"];
        _pubDate = dict[@"pubDate"];
    }
    
    return self;
}

@end
