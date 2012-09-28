//
//  HorizMouseView.m
//  NFSJoystick
//
//  Created by  on 11-11-24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "HorizMouseView.h"

@implementation HorizMouseView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Rotates the view.
        CGAffineTransform transform = CGAffineTransformMakeRotation(3.14159/2);
        self.view.transform = transform;
        
        // Repositions and resizes the view.
        CGRect contentRect = CGRectMake(0, 0, 480, 320);
        self.view.bounds = contentRect;
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
