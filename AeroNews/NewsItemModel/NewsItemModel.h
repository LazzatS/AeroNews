//
//  NewsItemModel.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsItemModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *itemDescription;
@property (nonatomic, copy) NSDate *pubDate;
@property (nonatomic, copy) NSString *videoURL;
@property (nonatomic, copy) NSString *enclosure;
@property (nonatomic, copy) NSString *ImageURL;
@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithDictionary: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
