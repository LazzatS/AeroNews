//
//  ItemModel.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import "ItemModel.h"

@implementation ItemModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    
    self = [super init];
    
    if (self) {
        _title = [dict[@"title"] copy];
        _link = [dict[@"link"] copy];
        _itemDescription = [dict[@"description"] copy];
        _pubDate = [dict[@"pubDate"] copy];
    }
    
    return self;
    
}

@end
