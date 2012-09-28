//
//  LSWebViewController.h
//  Locoso
//
//  Created by zhiwei ma on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NFSBaseViewController.h"

@interface LSWebViewController : NFSBaseViewController
<UIWebViewDelegate>
{
    UIWebView* _webView;
    NSURL* _url;
    NSURL* _loadedURL;
}
@property (nonatomic, retain) NSURL* url;

- (void)startLoad;
- (BOOL)isLoading;
- (void)cancelLoad;
@end
