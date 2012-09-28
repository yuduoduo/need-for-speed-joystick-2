//
//  LSHTTPImageKit.h
//  Test1
//
//  Created by zhiwei ma on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSHTTPKit.h"
#import "ASIDownloadCache.h"

@class LSHTTPImageKit;

@protocol LSHTTPImageKitDelegate
@optional
- (void)didImageFinished:(LSHTTPImageKit*)aKit imageURL:(NSString*)aImageURL image:(UIImage*)aImage;
- (void)didImageFailed:(LSHTTPImageKit*)aKit imageURL:(NSString*)aImageURL;
@end

@interface LSHTTPImageKit : LSHTTPKit<ASIHTTPRequestDelegate>
{
    NSMutableDictionary* _dictImageURLAndDelegate;
    
    ASIDownloadCache* _downloadCache;
}
+ (LSHTTPImageKit*)imageKit;
- (LSHTTPRequestID)addImage:(NSString*)aImageURL delegate:(id<LSHTTPImageKitDelegate>)aDelegate;//useCache = YES
- (LSHTTPRequestID)addImage:(NSString*)aImageURL delegate:(id<LSHTTPImageKitDelegate>)aDelegate useCache:(BOOL)aUseCache;
@end
