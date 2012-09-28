//
//  LSHTTPKit.m
//  Test1
//
//  Created by zhiwei ma on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSHTTPKit.h"

@implementation LSHTTPKit
static LSHTTPKit* _sHTTPKit;
+ (LSHTTPKit*)sharedInstance
{
    if (!_sHTTPKit) 
    {
		@synchronized(self) 
        {
			if (!_sHTTPKit) 
            {
                _sHTTPKit = [[self alloc] init];
			}
		}
	}
	return _sHTTPKit;
}

- (void)dealloc
{
    [_reqQueue cancelAllOperations];
    
    [super dealloc];
}

- (LSHTTPRequestID)addRequest:(ASIHTTPRequest*)aRequest
{
    if (nil == aRequest)
    {
        NSLog(@"%@ addRequest failed!",NSStringFromClass([self class]));
        return -1;
    }
    
    if (nil == _reqQueue)
    {
        _reqQueue = [[ASINetworkQueue alloc] init];
    }
    
    srandom(time(nil));
	LSHTTPRequestID reqID = (NSInteger)random();
    aRequest.tag = reqID;
    [_reqQueue addOperation:aRequest];
    [_reqQueue go];
    return reqID;
}

- (void)setSuspended:(BOOL)aSuspend
{
    [_reqQueue setSuspended:aSuspend];
}

- (void)cancelRequest:(LSHTTPRequestID)aReqID
{
    LSHTTPRequest* request = nil;
    for (LSHTTPRequest* req in [_reqQueue operations])
    {
        if (aReqID == req.tag)
        {
            request = req;
            break;
        }
    }
    [request clearDelegatesAndCancel];
}

- (void)cancelAllRequest
{
    [_reqQueue cancelAllOperations];
}
@end
