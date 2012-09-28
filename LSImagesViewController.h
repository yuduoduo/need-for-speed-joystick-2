//
//  LSImagesViewController.h
//  Test1
//
//  Created by zhiwei ma on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NFSBaseViewController.h"
#import "LSHTTPImageKit.h"

#define LSImageMemoryCacheMaxCount 10

@interface LSImagesViewController : NFSBaseViewController
<LSHTTPImageKitDelegate>
{
    LSHTTPImageKit* _imageKit;
    NSMutableArray* _arrMatch;
    NSMutableDictionary* _memoryCache;
    BOOL _useMemoryCache;
}
@property (nonatomic) BOOL useMemoryCache;
@property (nonatomic, retain) LSHTTPImageKit* imageKit;

- (void)addImage:(UIImageView*)aImageView imageURL:(NSString*)aImageURL;//use cache
- (void)addImage:(UIImageView*)aImageView imageURL:(NSString*)aImageURL useCache:(BOOL)aUseCache;
- (void)addImage:(UIImageView*)aImageView imageURL:(NSString*)aImageURL useCache:(BOOL)aUseCache needCache:(BOOL)aNeedCache;

- (void)addImageForButton:(UIButton*)aButton imageURL:(NSString*)aImageURL;//use cache
- (void)addImageForButton:(UIButton*)aButton imageURL:(NSString*)aImageURL useCache:(BOOL)aUseCache;

- (void)addImage:(NSString*)aImageURL useCache:(BOOL)aUseCache;
- (void)addImage:(NSString*)aImageURL useCache:(BOOL)aUseCache needCache:(BOOL)aNeedCache;
- (UIImage*)handleImageHook:(UIImage*)aSrcImage;//图片返回后，在显示前提供一次处理的机会.默认返回原图.
@end
