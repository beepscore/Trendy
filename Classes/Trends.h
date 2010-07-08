//
//  Trends.h
//  Trendy
//
//  Created by Steve Baker on 2/28/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Trends : NSObject {
    // Xcode automatically adds instance variables to back properties
}

@property(nonatomic, retain)NSURL *baseURL;
@property(nonatomic, retain)NSURLConnection *connection;
@property(nonatomic, retain)NSMutableString *trendsJSONString;

- (void)updateTrendsFile:(id)sender;

@end
