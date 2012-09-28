//
//  CircleRoundViewController.m
//  NFSJoystick
//
//  Created by yongchang hu on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CircleRoundViewController.h"

@interface CircleRoundViewController ()

@end

@implementation CircleRoundViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *back = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mode_selection_view_background.png"]] autorelease];
    back.frame = CGRectMake(0, 146, 320, 334);
    [self.view addSubview:back];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
