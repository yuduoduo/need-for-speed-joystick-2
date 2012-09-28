//
//  LSParseDataUtils.m
//  Locoso
//
//  Created by zhiwei ma on 12-3-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSParseDataUtils.h"

@implementation LSParseDataUtils

+ (LSDataSession*)parseSession:(NSDictionary*)aJSONData
{
    LSDataSession* session = [[[LSDataSession alloc] init] autorelease];
    session.uaid = [[aJSONData valueForKey:LSJSONKEY_uaid] stringValue];
    session.session = [aJSONData valueForKey:LSJSONKEY_session];
    return session;
}

+ (LSDataAD*)parseAd:(NSDictionary*)aJSONData
{
    LSDataAD* ad = [[[LSDataAD alloc] init] autorelease];
    ad.imageURL = [aJSONData valueForKey:LSJSONKEY_value];
    ad.url = [aJSONData valueForKey:LSJSONKEY_url];
    return ad;
}
@end
