//
//  TrendyViewController.m
//  Trendy
//
//  Created by Steve Baker on 2/25/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import "TrendyViewController.h"
#import "Debug.h"

@implementation TrendyViewController

@synthesize webView, activityIndicator, downloadedData, baseURL, connection;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [self readTrendsFile:self];
}


#pragma mark -
#pragma mark memory management
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)setView:(UIView *)newView {
    if (nil == newView) {
        self.webView = nil;
        self.activityIndicator = nil;
    }    
    [super setView:newView];
}


- (void)dealloc {
    [webView release], webView = nil;
    [activityIndicator release], activityIndicator = nil;
    [downloadedData release], downloadedData = nil;
    [connection release], connection = nil;
    [baseURL release], baseURL = nil;
    
    [super dealloc];
}


#pragma mark -
#pragma mark handle UI inputs
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return ((interfaceOrientation == UIInterfaceOrientationPortrait)
            || (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
            || (interfaceOrientation == UIInterfaceOrientationLandscapeRight));
}


#pragma mark IBAction
- (IBAction)handleGoBack:(id)sender {
    [self.webView goBack];    
}


- (IBAction)readTrendsFile:(id)sender {
    // NSURL *url = [[NSURL alloc] initWithString:@"http://google.com"];
    
    NSString *trendsPath =[[NSBundle mainBundle]
                           pathForResource:@"trends" ofType:@"html"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:trendsPath isDirectory:NO];
    
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
        [self.activityIndicator startAnimating];
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
    [self.activityIndicator stopAnimating];
    // We no longer need the connection, data, or baseURL.
    self.connection = nil;
    self.downloadedData = nil;
    self.baseURL = nil;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.webView loadData:self.downloadedData MIMEType:nil textEncodingName:nil baseURL:self.baseURL];
    [self.activityIndicator stopAnimating];
    // We no longer need the connection, data, or baseURL.
    self.connection = nil;
    self.downloadedData = nil;
    self.baseURL = nil;
}

@end