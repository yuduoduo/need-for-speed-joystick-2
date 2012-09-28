//
//  commonManager.m
//  Locoso
//
//  Created by yongchang hu on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "commonManager.h"


#import "SBJsonWriter.h"

@implementation commonManager

+(NSString*)getHostStr
{
    
   NSString *host = @"http://www.phonegamesofteware.cn/v1";

    return host;
}
@end
