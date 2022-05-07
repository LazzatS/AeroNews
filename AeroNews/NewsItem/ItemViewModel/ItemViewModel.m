//
//  ItemViewModel.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 01.05.2022.
//

#import "ItemViewModel.h"

@interface ItemViewModel ()

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *shortDescription;

@end

@implementation ItemViewModel

+ (id<ItemViewModelProtocol>)newAllocInit:(ItemModel *)itemModel {
    
    ItemDisplayModel *displayModel = [[[ItemDisplayModel alloc]
                                       initWithItemModel:itemModel]
                                      autorelease];
    ItemViewModel *itemViewModel = [[[ItemViewModel alloc]
                                     initWithItem:displayModel]
                                    autorelease];
    
    return itemViewModel;
}

- (instancetype)initWithItem:(ItemDisplayModel *)displayModel {
    
    self = [super init];
    
    if (self) {
        self.url = [NSURL URLWithString:displayModel.itemURL];
        self.title = displayModel.itemTitle;
        self.date = displayModel.itemDate;
        self.shortDescription = displayModel.itemDescription;
    }
    
    return self;
}

- (void)loadWebView:(void (^)(NSURLRequest *))completion {
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    completion(request);
}

- (void)getNewsItemDetails: (void (^)(NSString *,
                                      NSString *,
                                      NSString *))completion {
    
    completion(self.title, self.shortDescription, self.date);
    
}

- (NSURL *)getCurrentURL {
    return self.url;
}

@end
