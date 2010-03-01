//
//  Trends.h
//  Trendy
//
//  Created by Steve Baker on 2/28/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Trends : NSObject {
    NSMutableData *downloadedData;
    NSURL *baseURL;
    NSURLConnection *connection;
}
@property(nonatomic, retain)NSMutableData *downloadedData;
@property(nonatomic, retain)NSURL *baseURL;
@property(nonatomic, retain)NSURLConnection *connection;

@end
