//
//  TroubleShootViewController.m
//  NFSJoystick
//
//  Created by  on 11-10-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "TroubleShootViewController.h"
#import "MsgComm.h"
@implementation TroubleShootViewController
@synthesize WebView;

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
    //current language
    GET_LOCAL_LANGUAGE
    NSLog(@"language %@",currentLanguage);
    
    NSString* trouble_name;
    if ([currentLanguage isEqualToString: @"zh-Hans"]) {
        trouble_name = @"trouble_cn.html";
    }else if ([currentLanguage isEqualToString: @"zh-Hant"]) {
        trouble_name = @"trouble_tw.html";
    }else
    {
        trouble_name = @"trouble_en.html";
    }
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"boardBack.png"]];
    NSString *resourcePath = [ [NSBundle mainBundle] resourcePath];
	NSString *filePath = [resourcePath stringByAppendingPathComponent:trouble_name];
	NSString *htmlstring=[[NSString alloc] initWithContentsOfFile:filePath  encoding:NSUTF8StringEncoding error:nil];   
	[WebView loadHTMLString:htmlstring  baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];	
    [htmlstring release];
    
    WebView.backgroundColor = [UIColor clearColor];
    WebView.opaque = NO;
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
- (void)dealloc {
    [WebView release];
    [super dealloc];
}
@end
