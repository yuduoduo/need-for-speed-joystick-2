//
//  HelicopterAddViewController.m
//  NFSJoystick
//
//  Created by  on 12-4-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HelicopterAddViewController.h"
#import "LSWebViewController.h"
#import "MsgComm.h"
#import "UIImageEx.h"
@implementation HelicopterAddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    advertisePE = [[LSADPE alloc] init];
    advertisePE.delegate = self;
//    [advertisePE sendRequest];
//    [self startWaiting];
    [self initStoreAdsView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)close_buttonPressed
{
    DISAPPEAR_VIEW
}
#pragma mark ----------------
#pragma mark ads from network
-(void)openAdsUrl
{
    if (advertisePE.rspData.AD.url.length > 0) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:advertisePE.rspData.AD.url]];
    }
}
-(void)initAdsViewCompont{
    if (advertisePE.rspData.AD.whetherOpen) {
        LSWebViewController *web = [[[LSWebViewController alloc]init] autorelease];
        web.url = [NSURL URLWithString: advertisePE.rspData.AD.webDescriptionUrl];
        [self.view addSubview:web.view];
        
        UIImageView *adView = [[[UIImageView alloc]initWithFrame:CGRectMake(250, 400, 40, 20)] autorelease];
        [self addImage:adView imageURL:advertisePE.rspData.AD.imageURL];
        [self.view addSubview:adView];
        
        UIButton *button = [[[UIButton alloc]initWithFrame:CGRectMake(250, 400, 40, 20)] autorelease];
        [button addTarget:self action:@selector(openAdsUrl) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];                            
    }
}
#pragma mark ---------------
#pragma mark ads from local
#define NEXTBUTTONTAG 500
-(void)initStoreAdsView
{
    
    NSString* trouble_name = @"helicopter_ads_cn.html";
    
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"boardBack.png"]];
    NSString *resourcePath = [ [NSBundle mainBundle] resourcePath];
	NSString *filePath = [resourcePath stringByAppendingPathComponent:trouble_name];
	NSString *htmlstring=[[NSString alloc] initWithContentsOfFile:filePath  encoding:NSUTF8StringEncoding error:nil];   
    UIWebView *WebView = [[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 417)]autorelease];
    
	[WebView loadHTMLString:htmlstring  baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];	
    [htmlstring release];
    
    WebView.backgroundColor = [UIColor clearColor];
    WebView.opaque = NO;
    [self.view addSubview:WebView];
    
    
    //nutton
    UIButton* help_next = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Position the button - I found these numbers align fine (0, 0 = top left of keyboard)
    help_next.frame = CGRectMake(240, 430, 65, 39);
    help_next.bounds = CGRectMake(0, 0, 65, 39);
    [help_next addTarget:self action:@selector(openLocaAdsUrl) forControlEvents:UIControlEventTouchDown];
    help_next.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    
    [help_next.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
    [help_next setTitle:NSLocalizedString(@"view detail", @"view detail") forState:UIControlStateNormal];
    [help_next setBackgroundImage:[[UIImage imageNamed:@"help_next_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [help_next setBackgroundImage:[[UIImage imageNamed:@"help_next_highlighted_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    
    
    [self.view addSubview:help_next];
    
    
    //news
    // Set the Button Type.
    UIButton *news_button = [UIButton buttonWithType:UIButtonTypeCustom];
    news_button.tag = NEXTBUTTONTAG;
    // Position the button - I found these numbers align fine (0, 0 = top left of keyboard)
    news_button.frame = CGRectMake(15, 430, 65, 39);
    news_button.bounds = CGRectMake(0, 0, 65, 39);
    [news_button addTarget:self action:@selector(close_buttonPressed) forControlEvents:UIControlEventTouchDown];
    news_button.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    
    [news_button.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
    [news_button setTitle:NSLocalizedString(@"Close", @"button Close") forState:UIControlStateNormal];
    // Add images to our button so that it looks just like a native UI Element.
    [news_button setBackgroundImage:[UIImageEx rotateImage:[[UIImage imageNamed:@"help_next_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] ]  forState:UIControlStateNormal];
    [news_button setBackgroundImage:[UIImageEx rotateImage:[[UIImage imageNamed:@"help_next_highlighted_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0]]  forState:UIControlStateHighlighted];
    
    [self.view addSubview:news_button];
    
}
-(void)openLocaAdsUrl
{
    NSString *url = @"http://www.ai-iphone.com";
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
}
#pragma mark LSBaseProtocolEngineDelegate
- (void)didProtocolEngineFinished:(LSBaseProtocolEngine*)aEngine newData:(id)aData
{
    [self initAdsViewCompont];
    [self stopWaiting];
}

- (void)didProtocolEngineFailed:(LSBaseProtocolEngine *)aEngine error:(NSError*)aError
{
    
    [self stopWaiting];
    NSLog(@"%s %@",__FUNCTION__, aError);
}
@end
