//
//  LSHTTPImageKit.m
//  Test1
//
//  Created by zhiwei ma on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSHTTPImageKit.h"

@implementation LSHTTPImageKit
+ (LSHTTPImageKit*)imageKit
{
    LSHTTPImageKit* kit = [[[LSHTTPImageKit alloc] init] autorelease];
    return kit;
}

- (void)dealloc
{
    [_dictImageURLAndDelegate release];
    [_downloadCache release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _dictImageURLAndDelegate = [[NSMutableDictionary alloc] initWithCapacity:50];
        _downloadCache = [[ASIDownloadCache alloc] init];
        _downloadCache.storagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"ImageCache"];
    }
    return self;
}

- (LSHTTPRequestID)addImage:(NSString*)aImageURL delegate:(id<LSHTTPImageKitDelegate>)aDelegate
{
    return [self addImage:aImageURL delegate:aDelegate useCache:YES];
}

- (LSHTTPRequestID)addImage:(NSString*)aImageURL delegate:(id<LSHTTPImageKitDelegate>)aDelegate useCache:(BOOL)aUseCache
{
    return [self addImage:aImageURL delegate:aDelegate useCache:aUseCache needCache:YES];
}

- (LSHTTPRequestID)addImage:(NSString*)aImageURL delegate:(id<LSHTTPImageKitDelegate>)aDelegate useCache:(BOOL)aUseCache needCache:(BOOL)aNeedCache
{
    if ([aImageURL length] == 0)
    {
        NSLog(@"%@ addImage failed!", NSStringFromClass([self class]));
        //        return -1;
    }
#ifdef LSHTTPIMAGEKITDEBUG
    NSLog(@"%s imageURL= %@",__FUNCTION__,aImageURL);
#endif
    NSURL* url = [NSURL URLWithString:aImageURL];
    if (nil == url)
    {
        NSLog(@"url is invalid. %@",aImageURL);
        if (aDelegate && [(NSObject*)aDelegate respondsToSelector:@selector(didImageFailed:imageURL:)])
        {
            [aDelegate didImageFailed:self imageURL:aImageURL];
        }
        return -1;
    }
    
    LSHTTPRequest* request =  [[[LSHTTPRequest alloc] initWithURL:url] autorelease];
    request.delegate = self;
    request.downloadCache = _downloadCache;
    if (aUseCache)
    {
        request.cachePolicy = ASIAskServerIfModifiedWhenStaleCachePolicy;
    }
    else 
    {
        request.cachePolicy = ASIDoNotReadFromCacheCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy;
    }
    if (aNeedCache)
    {
        request.cacheStoragePolicy = ASICachePermanentlyCacheStoragePolicy;
        request.secondsToCache = 60*60*24*7;//7天
    }
    else 
    {
        request.cachePolicy = ASIDoNotWriteToCacheCachePolicy | ASIDoNotReadFromCacheCachePolicy;
    }
    
    if (aDelegate && [aImageURL length] > 0)
    {
        [_dictImageURLAndDelegate setObject:aDelegate forKey:aImageURL];
    }
    return [self addRequest:request];
}
#pragma mark ASIHTTPRequestDelegate
- (void)requestFinished:(LSHTTPRequest*)request
{
    BOOL useCacheFlag = [request didUseCachedResponse];
    NSLog(@"image useCache %d",useCacheFlag);
    NSString* imageURL = [request.url absoluteString];
    id delegate = [_dictImageURLAndDelegate valueForKey:imageURL];
    if (delegate && [(NSObject*)delegate respondsToSelector:@selector(didImageFinished:imageURL:image:)])
    {
        NSData* rspData = [request responseData];
        UIImage* image = nil; 
        if (rspData)
        {
            image = [[UIImage alloc] initWithData:rspData];
        }
        if (image)
        {
            [delegate didImageFinished:self imageURL:imageURL image:image];
        }
        [image release];
    }
}

- (void)requestFailed:(ASIHTTPRequest*)request
{
    NSString* imageURL = [request.url absoluteString];
    id delegate = [_dictImageURLAndDelegate valueForKey:imageURL];
    if (delegate && [(NSObject*)delegate respondsToSelector:@selector(didImageFailed:imageURL:)])
    {
        [delegate didImageFailed:self imageURL:imageURL];
    }
}
@end
