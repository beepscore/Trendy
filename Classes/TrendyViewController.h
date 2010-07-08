//
//  TrendyViewController.h
//  Trendy
//
//  Created by Steve Baker on 2/25/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Trends;

@interface TrendyViewController : UIViewController <UIWebViewDelegate>{
    // Xcode automatically adds instance variables to back properties
}

@property(nonatomic, retain)IBOutlet UIWebView *webView;
@property(nonatomic, retain)IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic, retain)NSMutableData *downloadedData;
@property(nonatomic, retain)NSURL *baseURL;
@property(nonatomic, retain)NSURLConnection *connection;
@property(nonatomic, retain)Trends *trends;

- (IBAction)handleGoBack:(id)sender;
- (IBAction)updateTrends:(id)sender;

@end

