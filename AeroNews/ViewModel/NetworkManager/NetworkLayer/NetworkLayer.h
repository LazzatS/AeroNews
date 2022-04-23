//
//  NetworkLayer.h
//  AeroNews
//
//  Created by Lazzat Seiilova on 16.04.2022.
//

#import "NetworkLayerProtocol.h"
#import "Loader.h"
#import "XMLParser.h"

@interface NetworkLayer : NSObject <NetworkLayerProtocol>

- (instancetype)initWithLoader: (id<LoaderProtocol>)loader
                     andParser: (id<ParserProtocol>)parser;

@end
