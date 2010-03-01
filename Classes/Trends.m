//
//  Trends.m
//  Trendy
//
//  Created by Steve Baker on 2/28/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "Trends.h"
#import "CJSONDeserializer.h"
#import "Debug.h"

@implementation Trends

@synthesize baseURL;
@synthesize connection;
@synthesize resultsString;

- (void)dealloc {
    [connection release], connection = nil;
    [baseURL release], baseURL = nil;
    [resultsString release], resultsString = nil;
    
    [super dealloc];
}


#pragma mark -
#pragma mark Parse JSON
- (NSDictionary *)dictionaryForJSONString:(NSString *)aJSONString {
    NSData *jsonData = [aJSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:nil];
    return dictionary;
}


- (NSDictionary *)trendsDictionaryForTrendsJSONString:(NSString *)aTrendsJSONString {
    NSDictionary *outerDictionary = [self dictionaryForJSONString:aTrendsJSONString];
    NSDictionary *trendsDictionary = [outerDictionary objectForKey:@"trends"];
    return trendsDictionary;
}


- (void)writeTrendsHTMLFileForDictionary:(NSDictionary *)aTrendsDictionary {
    
    // Ref: http://moodle.extn.washington.edu/mod/forum/discuss.php?d=4675
    
    NSString *trendsTopPath =[[NSBundle mainBundle]
                              pathForResource:@"trends_top" ofType:@"html"];
    
    
    NSMutableString *trendsHTMLString = [[NSMutableString alloc]
                                         initWithContentsOfFile:trendsTopPath
                                         encoding:NSUTF8StringEncoding
                                         error:NULL];
    
    [trendsHTMLString appendString:@"        <ol>\n"];
    
    for ( NSDictionary* trend in aTrendsDictionary ) {
        
        [trendsHTMLString appendFormat:@"            <li><a href=\"%@\">%@</a></li>\n", 
         [trend objectForKey:@"url"], [trend objectForKey:@"name"]];
    }
    
    [trendsHTMLString appendString:@"        </ol>\n"];
    [trendsHTMLString appendString:@"    </body>\n"];
    [trendsHTMLString appendString:@"</html>\n"];
    
    DLog(@"trendsHTMLString = %@", trendsHTMLString);
    
    NSString *trendsPath =[[NSBundle mainBundle]
                           pathForResource:@"trends" ofType:@"html"];
    
    [trendsHTMLString writeToFile:trendsPath
                       atomically:YES 
                         encoding:NSUTF8StringEncoding 
                            error:NULL];
    [trendsHTMLString release];
}



- (IBAction)getTrendsJSON:(id)sender {
    NSURL *url = [[NSURL alloc] initWithString:@"http://search.twitter.com/trends.json"];
    
    self.baseURL = url;
    [url release], url = nil;
    DLog(@"self.baseURL = %@", self.baseURL); 
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.baseURL];

    // New data to download.
    NSMutableString *tempString = [[NSMutableString alloc] init];
    self.resultsString = tempString;
    [tempString release], tempString = nil;
    
    NSURLConnection *newConnection = [[NSURLConnection alloc] 
                                      initWithRequest:request 
                                      delegate:self 
                                      startImmediately:YES];
    if (nil == newConnection) {
        NSLog(@"Could not create connection");
    } else {
        self.connection = newConnection;
    }
    
    [newConnection release], newConnection = nil;
    [request release], request = nil;    
}

#pragma mark -
#pragma mark NSURLConnection delegate callbacks
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	DLog(@"connectionDidReceiveResponse");
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString *newText = [[NSString alloc]
                         initWithData:data
                         encoding:NSUTF8StringEncoding];
	if (NULL != newText) {
        [self.resultsString appendString:newText];
		[newText release];
	}    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed: %@", error);
    // We no longer need the connection, data, or baseURL.
    self.connection = nil;
    self.baseURL = nil;
    self.resultsString = nil;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    DLog(@"resultsString = %@", self.resultsString);
    
    // TODO:  write html file here
    // [self.webView loadData:self.downloadedData MIMEType:nil textEncodingName:nil baseURL:self.baseURL];
    // We no longer need the connection, data, or baseURL.
    self.connection = nil;
    self.baseURL = nil;
    self.resultsString = nil;
}

@end
