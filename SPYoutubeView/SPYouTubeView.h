//
//  YouTubeView.h
//  IBM
//
//  Created by shinren Pan on 2011/4/15.
//  Copyright 2011 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#define YOUTUBEURL @"\
<html><head>\
<meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no\"/>\
<style type=\"text/css\">\
body {\
background-color: transparent;\
color: white;\
}\
</style>\
</head><body style=\"margin:0\">\
<embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
width=\"%0.0f\" height=\"%0.0f\"></embed>\
</body></html>"

@interface SPYouTubeView : UIWebView {
	NSString *videoURL;
}
@property(nonatomic ,retain)NSString *videoURL;
- (id)initWithFrame:(CGRect)frame andUrl:(NSString *)url;
@end
