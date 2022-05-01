//
//  ItemDisplayModel.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 01.05.2022.
//

#import "ItemDisplayModel.h"

@implementation ItemDisplayModel

- (instancetype)initWithItemModel:(ItemModel *)itemModel {
    
    self = [super init];
    
    if (self) {
        self.itemTitle = itemModel.title;
        self.itemURL = itemModel.link;
    }
    
    return self;
}

@end
