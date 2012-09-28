//
//  QuickSwitchHelpView.m
//  NFSJoystick
//
//  Created by  on 12-2-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuickSwitchHelpView.h"
#import "MsgComm.h"
@implementation QuickSwitchHelpView
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
-(void)help_buttonPressed:(UIButton *)button
{
    DISAPPEAR_VIEW
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //current language
    GET_LOCAL_LANGUAGE
    NSLog(@"language %@",currentLanguage);
    
    NSString* trouble_name;
    if ([currentLanguage isEqualToString: @"zh-Hans"]) {
        trouble_name = @"QuickSwitchHelp_cn.html";
    }else if ([currentLanguage isEqualToString: @"zh-Hant"]) {
        trouble_name = @"QuickSwitchHelp_tw.html";
    }else
    {
        trouble_name = @"QuickSwitchHelp_en.html";
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

    //nutton
    UIButton* help_next = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Position the button - I found these numbers align fine (0, 0 = top left of keyboard)
    help_next.frame = CGRectMake(240, 430, 65, 39);
    help_next.bounds = CGRectMake(0, 0, 65, 39);
    [help_next addTarget:self action:@selector(help_buttonPressed:) forControlEvents:UIControlEventTouchDown];
    help_next.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    
    [help_next.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
    [help_next setTitle:NSLocalizedString(@"Done", @"button done") forState:UIControlStateNormal];
    [help_next setBackgroundImage:[[UIImage imageNamed:@"help_next_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [help_next setBackgroundImage:[[UIImage imageNamed:@"help_next_highlighted_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    
    
    [self.view addSubview:help_next];
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

@end
