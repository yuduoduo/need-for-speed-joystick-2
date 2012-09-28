//
//  SPYouTubeView.m
//  
//
//  Created by shinren Pan on 2011/4/15.
//  Copyright 2011 home. All rights reserved.
//

#import "SPYouTubeView.h"

@implementation SPYouTubeView
@synthesize videoURL;

- (id)initWithFrame:(CGRect)frame andUrl:(NSString *)url
{
    
    self = [super initWithFrame:frame];
    if (self) {
		self.videoURL = url;
		[(UIScrollView *)[[self subviews]objectAtIndex:0]setBounces:NO];
		[(UIScrollView *)[[self subviews]objectAtIndex:0]setScrollEnabled:NO];
    }
    return self;
}
- (void)didMoveToSuperview
{
	[self loadHTMLString:[NSString stringWithFormat:YOUTUBEURL, videoURL, self.bounds.size.width, self.bounds.size.height] baseURL:nil];
}
- (void)dealloc {
	self.videoURL = nil;
    [super dealloc];
}
@end
