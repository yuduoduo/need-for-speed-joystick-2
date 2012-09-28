//
//  LSImagesViewController.m
//  Test1
//
//  Created by zhiwei ma on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSImagesViewController.h"

#pragma mark - LSImageMatch
@interface LSImageMatch : NSObject
{
    UIView* _view;
    NSString* _imageURL;
}
@property (nonatomic, retain) UIView* view;
@property (nonatomic, retain) NSString* imageURL;
@end

@implementation LSImageMatch
@synthesize view = _view;
@synthesize imageURL = _imageURL;
- (void)dealloc
{
    self.view = nil;
    self.imageURL = nil;
    [super dealloc];
}
@end

#pragma mark - LSImagesViewController
@interface LSImagesViewController ()
- (void)addImageToMemoryCache:(UIImage*)aImage urlString:(NSString*)aImageURL;
- (UIImage*)imageInMemoryCache:(NSString*)aImageURL;
@end

@implementation LSImagesViewController
@synthesize imageKit = _imageKit;
@synthesize useMemoryCache = _useMemoryCache;

- (void)dealloc
{
    self.imageKit = nil;
    [_arrMatch release];
    [_memoryCache release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_imageKit setSuspended:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_imageKit setSuspended:YES];
    [_memoryCache release];
    _memoryCache = nil;
}

#pragma mark custom methods
- (void)addImage:(UIImageView*)aImageView imageURL:(NSString*)aImageURL
{
    [self addImage:aImageView imageURL:aImageURL useCache:YES];
}

- (void)addImage:(UIImageView*)aImageView imageURL:(NSString*)aImageURL useCache:(BOOL)aUseCache
{
    [self addImage:aImageView imageURL:aImageURL useCache:aUseCache needCache:YES];
}

- (void)addImage:(UIImageView*)aImageView imageURL:(NSString*)aImageURL useCache:(BOOL)aUseCache needCache:(BOOL)aNeedCache
{
    if (nil == aImageView || [aImageURL length] == 0)
    {
        NSLog(@"%@ addImage failed!",NSStringFromClass([self class]));
        return;
    }
    
    if (NO == aUseCache)
    {
        [_memoryCache removeObjectForKey:aImageURL];
    }
    else 
    {
        UIImage* image = [self imageInMemoryCache:aImageURL];
        if (image)
        {
            aImageView.image = [self handleImageHook:image];
            //            [self didImageFinished:_imageKit imageURL:aImageURL image:image];
            NSLog(@"imageURL= %@\n image memeory cache",aImageURL);
            return;
        }
    }
    
    if (nil == _imageKit)
    {
        _imageKit = [[LSHTTPImageKit alloc] init];
    }
    [_imageKit addImage:aImageURL delegate:self useCache:aUseCache needCache:aNeedCache];
    
    if (nil == _arrMatch)
    {
        _arrMatch = [[NSMutableArray alloc] initWithCapacity:10];
    }
    LSImageMatch* match = [[LSImageMatch alloc] init];
    match.view  = aImageView;
    match.imageURL = aImageURL;
    [_arrMatch addObject:match];
    [match release];
}

- (void)addImageForButton:(UIButton*)aButton imageURL:(NSString*)aImageURL
{
    [self addImageForButton:aButton imageURL:aImageURL useCache:YES];
}

- (void)addImageForButton:(UIButton*)aButton imageURL:(NSString*)aImageURL useCache:(BOOL)aUseCache
{
    if (nil == aButton || [aImageURL length] == 0)
    {
        NSLog(@"%@ addImage failed!",NSStringFromClass([self class]));
        return;
    }
    
    if (NO == aUseCache)
    {
        [_memoryCache removeObjectForKey:aImageURL];
    }
    else 
    {
        UIImage* image = [self imageInMemoryCache:aImageURL];
        if (image)
        {
            [aButton setImage:[self handleImageHook:image] forState:UIControlStateNormal];
            NSLog(@"imageURL= %@\n image memeory cache",aImageURL);
            return;
        }
    }
    
    if (nil == _imageKit)
    {
        _imageKit = [[LSHTTPImageKit alloc] init];
    }
    [_imageKit addImage:aImageURL delegate:self useCache:aUseCache];
    
    if (nil == _arrMatch)
    {
        _arrMatch = [[NSMutableArray alloc] initWithCapacity:10];
    }
    LSImageMatch* match = [[LSImageMatch alloc] init];
    match.view  = aButton;
    match.imageURL = aImageURL;
    [_arrMatch addObject:match];
    [match release];
}

- (void)addImage:(NSString*)aImageURL useCache:(BOOL)aUseCache
{
    [self addImage:aImageURL useCache:aUseCache needCache:YES];
}

- (void)addImage:(NSString*)aImageURL useCache:(BOOL)aUseCache needCache:(BOOL)aNeedCache
{
    if ([aImageURL length] == 0)
    {
        NSLog(@"%@ addImage failed_2!",NSStringFromClass([self class]));
        //        return;
    }
    
    if (NO == aUseCache)
    {
        [_memoryCache removeObjectForKey:aImageURL];
    }
    else 
    {
        if (_useMemoryCache)
        {
            UIImage* image = [self imageInMemoryCache:aImageURL];
            if (image)
            {
                image = [self handleImageHook:image];
                [self didImageFinished:_imageKit imageURL:aImageURL image:image];
                NSLog(@"imageURL= %@\n image memeory cache",aImageURL);
                return;
            }
        }
    }
    
    if (nil == _imageKit)
    {
        _imageKit = [[LSHTTPImageKit alloc] init];
    }
    [_imageKit addImage:aImageURL delegate:self useCache:aUseCache needCache:aNeedCache];
}

- (UIImage*)handleImageHook:(UIImage*)aSrcImage
{
    return aSrcImage;
}

- (void)addImageToMemoryCache:(UIImage*)aImage urlString:(NSString*)aImageURL
{    
    if (nil == _memoryCache)
    {
        _memoryCache = [[NSMutableDictionary alloc] initWithCapacity:20];
    }
    
    NSInteger cacheCount = [[_memoryCache allKeys] count];
    if (_useMemoryCache)
    {
        if (cacheCount <= LSImageMemoryCacheMaxCount)
        {
            [_memoryCache setObject:aImage forKey:aImageURL];
        }
        else
        {
            NSString* key = [[_memoryCache allKeys] objectAtIndex:0];
            [_memoryCache removeObjectForKey:key];
            [_memoryCache setObject:aImage forKey:aImageURL];
        }
    }
}

- (UIImage*)imageInMemoryCache:(NSString*)aImageURL
{
    if ([aImageURL length] == 0)
    {
        return nil;
    }
    
    if (nil == _memoryCache)
    {
        _memoryCache = [[NSMutableDictionary alloc] initWithCapacity:20];
        return nil;
    }
    else 
    {
        UIImage* image = [_memoryCache valueForKey:aImageURL];
        return image;
    }
}

#pragma mark LSHTTPImageKitDelegate
- (void)didImageFinished:(LSHTTPImageKit*)aKit imageURL:(NSString*)aImageURL image:(UIImage*)aImage
{
    NSAssert(_imageKit == aKit, @"");
    
    LSImageMatch* match = nil;
    for (NSInteger i = 0; i < [_arrMatch count]; i++)
    {
        match = [_arrMatch objectAtIndex:i];
        if ([match.imageURL isEqualToString:aImageURL])
        {
            if ([match.view isKindOfClass:[UIImageView class]])
            {
                UIImageView* imageView = (UIImageView*)match.view;
                imageView.image = [self handleImageHook:aImage];
            }
            else if ([match.view isKindOfClass:[UIButton class]])
            {
                UIButton* button = (UIButton*)match.view;
                [button setImage:[self handleImageHook:aImage] forState:UIControlStateNormal];
            }
            [_arrMatch removeObject:match];
        }
    }
    
    if (_useMemoryCache)
    {
        [self addImageToMemoryCache:aImage urlString:aImageURL];
    }
}

- (void)didImageFailed:(LSHTTPImageKit*)aKit imageURL:(NSString*)aImageURL
{
    NSAssert(_imageKit == aKit, @"");
    LSImageMatch* match = nil;
    for (NSInteger i = 0; i < [_arrMatch count]; i++)
    {
        match = [_arrMatch objectAtIndex:i];
        if ([match.imageURL isEqualToString:aImageURL])
        {
            [_arrMatch removeObject:match];
        }
    }
}
@end
