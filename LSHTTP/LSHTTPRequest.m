//
//  LSHTTPRequest.m
//  Test1
//
//  Created by zhiwei ma on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSHTTPRequest.h"
#import "ASIDownloadCache.h"

@implementation LSHTTPRequest
- (id)initWithURL:(NSURL *)newURL
{
    self = [super initWithURL:newURL];
    if (self)
    {
        self.downloadCache = [ASIDownloadCache sharedCache];
//        self.cachePolicy = ASIAskServerIfModifiedWhenStaleCachePolicy;
        self.cachePolicy = ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy;
        self.cacheStoragePolicy = ASICachePermanentlyCacheStoragePolicy;
        self.secondsToCache = 60*60*24*1;
        self.timeOutSeconds = 30;
    }
    return self;
}
@end

@implementation ASIHTTPRequest (LSCategory)
- (void)clearCache
{
    [self.downloadCache clearCachedResponsesForStoragePolicy:self.cacheStoragePolicy];
}
@end