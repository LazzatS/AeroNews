//
//  XMLParser.m
//  AeroNews
//
//  Created by Lazzat Seiilova on 02.02.2022.
//

#import "XMLParser.h"

@interface XMLParser () <NSXMLParserDelegate>

@property (nonatomic, strong) void (^completion)(NSArray<ItemModel *> *, NSError *);

@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) NSMutableArray *news;
@property (nonatomic, strong) NSMutableDictionary *newsItemDict;
@property (nonatomic, strong) NSMutableDictionary *parsingDict;
@property (nonatomic, strong) NSMutableString *parsingString;

@end

@implementation XMLParser

#pragma mark - Method to parse data into array
- (void)parseNews:(NSData *)data completion:(void (^)(NSArray<ItemModel *> *, NSError *))completion {
    self.completion = completion;
    
    self.parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
    self.parser.delegate = self;
    [self.parser parse];
}

#pragma mark - NSXMLParserDelegate methods

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (self.completion) {
        self.completion(nil, parseError);
    }
    
    [self resetParserState];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.news = [[NSMutableArray new] autorelease];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    if ([elementName isEqualToString:@"item"]) {
        self.newsItemDict = [[NSMutableDictionary new] autorelease];
        
    } else if ([elementName isEqualToString:@"title"] ||
               [elementName isEqualToString:@"link"] ||
               [elementName isEqualToString:@"description"] ||
               [elementName isEqualToString:@"pubDate"]) {
        
        self.parsingDict = [[NSMutableDictionary new] autorelease];
        self.parsingString = [[NSMutableString new] autorelease];
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
    
    if ([elementName isEqualToString:@"title"] ||
        [elementName isEqualToString:@"link"] ||
        [elementName isEqualToString:@"description"] ||
        [elementName isEqualToString:@"pubDate"]) {
        
        [self.newsItemDict addEntriesFromDictionary:self.parsingDict];
        self.parsingDict = nil;
        
    } else if ([elementName isEqualToString:@"item"]) {
        
        ItemModel *newsItem = [[[ItemModel alloc] initWithDictionary:self.newsItemDict] autorelease];
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
