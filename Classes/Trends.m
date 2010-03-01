//
//  Trends.m
//  Trendy
//
//  Created by Steve Baker on 2/28/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "Trends.h"
#import "Debug.h"

@implementation Trends
@synthesize downloadedData;
@synthesize baseURL;
@synthesize connection;


- (void)dealloc {
    [downloadedData release], downloadedData = nil;
    [connection release], connection = nil;
    [baseURL release], baseURL = nil;
    
    [super dealloc];
}

- (IBAction)getTrendsJSON:(id)sender {
    NSURL *url = [[NSURL alloc] initWithString:@"http://search.twitter.com/trends.json"];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    self.baseURL = url;
    [url release], url = nil;
    
    // New data to download.
    NSMutableData *data = [[NSMutableData alloc] init];
    self.downloadedData = data;
    [data release], data = nil;
    
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


#pragma mark NSURLConnection delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.downloadedData setLength:0];    
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.downloadedData appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed: %@", error);
    // We no longer need the connection, data, or baseURL.
    self.connection = nil;
    self.downloadedData = nil;
    self.baseURL = nil;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // TODO:  write html file here
    // [self.webView loadData:self.downloadedData MIMEType:nil textEncodingName:nil baseURL:self.baseURL];
    // We no longer need the connection, data, or baseURL.
    self.connection = nil;
    self.downloadedData = nil;
    self.baseURL = nil;
}

@end
