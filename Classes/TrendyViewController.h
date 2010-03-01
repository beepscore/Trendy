//
//  TrendyViewController.h
//  Trendy
//
//  Created by Steve Baker on 2/25/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrendyViewController : UIViewController <UIWebViewDelegate>{
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
    NSMutableData *downloadedData;
    NSURL *baseURL;
    NSURLConnection *connection;
}

@property(nonatomic, retain)IBOutlet UIWebView *webView;
@property(nonatomic, retain)IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic, retain)NSMutableData *downloadedData;
@property(nonatomic, retain)NSURL *baseURL;
@property(nonatomic, retain)NSURLConnection *connection;

- (IBAction)handleGoBack:(id)sender;
- (IBAction)readTrendsFile:(id)sender;

@end

