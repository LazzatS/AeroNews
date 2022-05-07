//
//  ItemDisplayModel.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 01.05.2022.
//

#import "ItemModel.h"

@interface ItemDisplayModel : NSObject

@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, strong) NSString *itemURL;
@property (nonatomic, strong) NSString *itemDate;
@property (nonatomic, strong) NSString *itemDescription;

- (instancetype)initWithItemModel:(ItemModel *)itemModel;

@end
