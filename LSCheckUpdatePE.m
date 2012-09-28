//
//  LSLoginInPE.m
//  Locoso
//
//  Created by yongchang hu on 12-3-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSCheckUpdatePE.h"
#import "commonManager.h"
#import "LSParseDataUtils.h"
#import "NSString+SBJSON.h"
@implementation LSCheckUpdatePE
@synthesize password = _password;
@synthesize loginName = _loginName;
@synthesize rspData = _rspData;
- (void)dealloc
{
    self.password = nil;
    self.loginName = nil;
    self.rspData = nil;
    [super dealloc];
}

- (LSHTTPRequest*)request
{
    NSString *strURL = [commonManager getHostStr];strURL = [strURL stringByAppendingString:@"/member.action?act=login&subgson="];
    
    NSString *subgson = [NSString stringWithFormat: @"{\"account\":{\"password\":\"%@\",\"loginname\":\"%@\"},\"model\":\"\",\"verify\":{\"time\":\"2012-01-10\",\"permit\":\"verify\"}}",_password, _loginName];
    strURL = [strURL stringByAppendingString:subgson];
    
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    LSHTTPRequest* request = [[LSHTTPRequest alloc] initWithURL:[NSURL URLWithString:strURL]];
    
    return [request autorelease];
}

- (LSBaseResponseData*)parseResponseData:(NSString*)aResponseString
{
    id jsonValue = [aResponseString JSONValue];
    if (nil == jsonValue)
    {
        return nil;
    }
    
    NSDictionary* jsonDic = (NSDictionary*)jsonValue;
    if ([jsonDic isKindOfClass:[NSDictionary class]])
    {
        
        LSLoginRspData* rspData = [[[LSLoginRspData alloc] init] autorelease];
        rspData.session = [LSParseDataUtils parseSession:jsonDic];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:rspData.session.uaid  forKey:@"uaid"];
        [defaults setObject:rspData.session.session  forKey:@"session"];
        [defaults synchronize];
        
        return rspData;
    }
    return nil;
}
- (BOOL)handleResponseData:(LSBaseResponseData*)aNewData
{
    self.rspData = (LSLoginRspData*)aNewData;
    return [super handleResponseData:aNewData];
}
@end
#pragma mark - LSLoginRspData
@implementation LSLoginRspData
@synthesize session = _session;
- (void)dealloc
{
    self.session = nil;
    [super dealloc];
}

@end
