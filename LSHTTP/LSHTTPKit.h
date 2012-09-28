//
//  LSHTTPKit.h
//  Test1
//
//  Created by zhiwei ma on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSHTTPRequest.h"
#import "ASINetworkQueue.h"

@interface LSHTTPKit : NSObject
{
    ASINetworkQueue* _reqQueue;
}
+ (LSHTTPKit*)sharedInstance;
- (LSHTTPRequestID)addRequest:(ASIHTTPRequest*)aRequest;
- (void)setSuspended:(BOOL)aSuspend;
- (void)cancelRequest:(LSHTTPRequestID)aReqID;
- (void)cancelAllRequest;
@end
