//
//  DemoViewController.m
//  Demo
//
//  Created by shinren Pan on 2011/6/28.
//  Copyright 2011 home. All rights reserved.
//

#import "DemoViewController.h"
#import "SPYouTubeView.h"
@implementation DemoViewController



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    NSString *str = @"http://www.youtube.com/watch?v=qSTUpoF5k5A";
    if ([currentLanguage isEqualToString:@"zh-Hans"]) {
        //chinese
        str = @"http://www.youtube.com/watch?v=qSTUpoF5k5A";
    }
	
	SPYouTubeView *youtube = [[SPYouTubeView alloc]initWithFrame:self.view.bounds andUrl:str];
	[self.view addSubview:youtube];
	[youtube release];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
