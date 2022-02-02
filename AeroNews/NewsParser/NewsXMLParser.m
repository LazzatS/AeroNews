//
//  NewsXMLParser.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import "NewsXMLParser.h"
#import "NewsItemModel.h"

@interface NewsXMLParser () <NSXMLParserDelegate>

@property (nonatomic, strong) void (^completion)(NSArray<NewsItemModel *> *, NSError *);

@property (nonatomic, strong) NSMutableArray *news;
@property (nonatomic, strong) NSMutableDictionary *newsItemDict;
@property (nonatomic, strong) NSMutableDictionary *parsingDict;
@property (nonatomic, strong) NSMutableString *parsingString;

@end

@implementation NewsXMLParser

- (void)parseNews:(NSData *)data completion:(void (^)(NSArray<NewsItemModel *> *, NSError *))completion {
    self.completion = completion;
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (self.completion) {
        self.completion(nil, parseError);
    }
    
    [self resetParserState];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.news = [NSMutableArray new];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    if ([elementName isEqualToString:@"item"]) {
        self.newsItemDict = [NSMutableDictionary new];
        
    } else if ([elementName isEqual:@"itunes:image"]) {
        NSMutableString *imageURL = [attributeDict objectForKey:@"href"] == nil
        ? [NSMutableString new]
        : [[attributeDict objectForKey:@"href"] mutableCopy];
        
        self.parsingDict = [NSMutableDictionary new];
        self.parsingString = imageURL;
        
    } else if ([elementName isEqual:@"enclosure"]) {
        NSMutableString *video_M4V_URL = [attributeDict objectForKey:@"url"] == nil
        ? [NSMutableString new]
        : [[attributeDict objectForKey:@"url"] mutableCopy];
        
        self.parsingDict = [NSMutableDictionary new];
        self.parsingString = video_M4V_URL;
        
    } else {
        self.parsingString = [NSMutableString new];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.parsingString appendString:string];
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
    if (self.parsingString) {
        [self.parsingDict setObject:self.parsingString forKey:elementName];
        self.parsingString = nil;
    }
    
    if ([elementName isEqualToString:@"item"]) {
        NewsItemModel *newsItem = [[NewsItemModel alloc] initWithDictionary:self.newsItemDict];
        [self.news addObject:newsItem];
        self.newsItemDict = nil;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (self.completion) {
        self.completion(self.news, nil);
    }
    
    [self resetParserState];
}

#pragma mark - Private method

- (void)resetParserState {
    self.completion = nil;
    self.news = nil;
    self.newsItemDict = nil;
    self.parsingDict = nil;
    self.parsingString = nil;
}

@end
