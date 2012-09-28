//
//  LSWebViewController.m
//  Locoso
//
//  Created by zhiwei ma on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSWebViewController.h"

@interface LSWebViewController ()

@end

@implementation LSWebViewController
@synthesize  url = _url;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"图片详情";
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (nil == _webView)
    {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(10,33,300,300)];
        _webView.backgroundColor = [UIColor clearColor];
        
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
        if ([_webView respondsToSelector:@selector(scrollView)])
        {
            _webView.scrollView.minimumZoomScale = 0.3;
            _webView.scrollView.maximumZoomScale = 3;
        }

        [self.view addSubview:_webView];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [_webView release];
    _webView = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_url)
    {
        [self startLoad];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.isLoading)
    {
        [self cancelLoad];
    }
    _webView.delegate = nil;
}

- (void)dealloc
{
    self.url = nil;
    [_loadedURL release];
    [_webView release];
    [super dealloc];
}

- (void)startLoad
{
    NSURLRequest* request = [NSURLRequest requestWithURL:_url];
    [_webView loadRequest:request];
    [self startWaiting];
}

- (BOOL)isLoading
{
    return _webView.isLoading;
}

- (void)cancelLoad
{
    [_webView stopLoading];
    [self stopWaiting];
}

#pragma mark UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webView load success. url= %@",_url.absoluteString);
    [self stopWaiting];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"webView load failed. url= %@",_url.absoluteString);
    [self stopWaiting];
    
}
@end
