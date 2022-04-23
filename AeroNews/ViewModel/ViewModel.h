//
//  NewsViewModel.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 13.03.2022.
//

#import "ViewModelProtocol.h"
#import "NetworkLayer.h"

@interface ViewModel : NSObject <ViewModelProtocol>

# pragma mark - Public properties
@property (nonatomic, strong) id<NetworkLayerProtocol> fetcher;
@property (nonatomic, weak) NSThread *thread;

@end
