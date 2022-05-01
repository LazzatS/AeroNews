//
//  NewsViewModel.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 13.03.2022.
//

#import "ViewModelProtocol.h"
#import "NetworkLayer.h"
#import "Constants.h"

@interface ViewModel : NSObject <ViewModelProtocol>

#pragma mark - Public properties
@property (nonatomic, strong) id<NetworkLayerProtocol> networkLayer;

#pragma mark - Custom initializer
- (instancetype)initWithNetworkLayer: (id<NetworkLayerProtocol>)networkLayer;

@end
