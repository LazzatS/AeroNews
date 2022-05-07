//
//  ItemModel.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import <UIKit/UIKit.h>

@interface ItemModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *itemDescription;
@property (nonatomic, copy) NSString *pubDate;

- (instancetype)initWithDictionary: (NSDictionary *)dict;

@end
