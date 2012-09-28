//
//  SettingViewController.m
//  NFSJoystick
//
//  Created by  on 11-10-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"
#import "FlipsideViewController.h"
#import "SupportViewController.h"
#import "RootViewController.h"
@implementation UINavigationBar (CustomImage)  
- (void)drawRect:(CGRect)rect {  
    UIImage *image = [UIImage imageNamed: @"NaviBar.png"];  
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];  
}  
@end 

@implementation SettingViewController
@synthesize flipsideViewController;
@synthesize supportViewController;

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
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviBar.png"] forBarMetrics:0];
    }else {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    }
    
    UIBarButtonItem *item = [[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(navigationRightButtonItemClicked)] autorelease];
    self.navigationItem.rightBarButtonItem = item;
    

    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    [self loadSettingScrollView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
-(void)navigationRightButtonItemClicked
{
    [rootviewController toggleToMain];
}
-(void)setRootViewController:(RootViewController*)controller;
{
    rootviewController = controller;
}
-(void)loadSettingScrollView
{
    settingScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];

    
    if (flipsideViewController == nil) {
		[self loadFlipsideViewController];
	}
	
    flipsideViewController.view.center = CGPointMake(160, 200);
    settingScrollView.contentSize = CGSizeMake(320, 980);
    
    if (supportViewController == nil) {
		[self loadSupportViewController];
	}
	
    supportViewController.view.center = CGPointMake(160, 680);
    
    //settingScrollView.backgroundColor = [UIColor clearColor];
	settingScrollView.showsVerticalScrollIndicator = NO;
    [settingScrollView addSubview:[flipsideViewController view]];
    [settingScrollView addSubview:[supportViewController view]];
    [self.view addSubview:settingScrollView];
    [settingScrollView release];
    
}
- (void)loadSupportViewController {
    
    SupportViewController *viewController = [[SupportViewController alloc] initWithNibName:@"SupportViewController" bundle:nil];
    self.supportViewController = viewController;
    [viewController release];	
}
- (void)loadFlipsideViewController {
    
    FlipsideViewController *viewController = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
    self.flipsideViewController = viewController;
    [viewController release];	
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
    [flipsideViewController release];
    [supportViewController release];
    [super dealloc];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [flipsideViewController viewWillDisappear:animated];
    [super viewWillDisappear:animated];
}
@end
