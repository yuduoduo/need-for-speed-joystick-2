//
//  LSADPE.m
//  Locoso
//
//  Created by zhiwei ma on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSADPE.h"
#import "commonManager.h"
#import "SBJson.h"
#import "LSParseDataUtils.h"
#import "NSString+SBJSON.h"
@implementation LSADPE
@synthesize rspData = _rspData;

- (void)dealloc
{
    self.rspData = nil;
    [super dealloc];
}

- (LSHTTPRequest*)request
{    
    NSString* strURL = [[commonManager getHostStr] stringByAppendingString:@"/clienta.action?as=1"];
    NSURL* url = [NSURL URLWithString:strURL];
    LSHTTPRequest* request = [[LSHTTPRequest alloc] initWithURL:url];
    request.cachePolicy = ASIDoNotReadFromCacheCachePolicy;
    return [request autorelease];
}

- (LSBaseResponseData*)parseResponseData:(NSString*)aResponseString
{
    id jsonValue = [aResponseString JSONValue];
    if (nil == jsonValue)
    {
        return nil;
    }
    
    NSDictionary* dict = (NSDictionary*)jsonValue;
    LSDataAD* ad= [LSParseDataUtils parseAd:dict];
    LSADRspData* rspData = [[[LSADRspData alloc] init] autorelease];
    rspData.AD = ad;
    return rspData;
}

- (BOOL)handleResponseData:(LSBaseResponseData*)aNewData
{
    self.rspData = (LSADRspData*)aNewData;
    return [super handleResponseData:aNewData];
}
@end

@implementation LSADRspData
@synthesize AD = _AD;

- (void)dealloc
{
    self.AD = nil;
    [super dealloc];
}
@end