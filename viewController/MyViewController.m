/*
     File: MyViewController.m
 Abstract: A controller for a single page of content. For this application, pages simply display text on a colored background. The colors are retrieved from a static color list.
  Version: 1.3
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
*/

#import "MyViewController.h"

static NSArray *__pageControlColorList = nil;

@implementation MyViewController


// Creates the color list the first time this method is invoked. Returns one color object from the list.
+ (UIColor *)pageControlColorWithIndex:(NSUInteger)index {
    if (__pageControlColorList == nil) {
        __pageControlColorList = [[NSArray alloc] initWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor magentaColor],
                                  [UIColor blueColor], [UIColor orangeColor], [UIColor brownColor], [UIColor grayColor], nil];
    }
	
    // Mod the index by the list length to ensure access remains in bounds.
    return [__pageControlColorList objectAtIndex:index % [__pageControlColorList count]];
}

// Load the view nib and initialize the pageNumber ivar.
- (id)initWithPageNumber:(int)page {
    if (self = [super initWithNibName:@"MyView" bundle:nil]) {
        pageNumber = page;
    }
    return self;
}

- (void)dealloc {
    
    [super dealloc];
}

// Set the label and background color when the view has finished loading.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSString* innumber = [NSString stringWithFormat:@"%i", pageNumber + 1];
	NSString *pictrureName = @"help_";
	pictrureName = [pictrureName stringByAppendingString:innumber];
	pictrureName = [pictrureName stringByAppendingString:@".png"];
	//self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:pictrureName]];
	help_view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:pictrureName]];
    help_view.center = CGPointMake(160, 174);
    [self.view addSubview:help_view];
    [help_view release];
    
    self.view.backgroundColor =[UIColor clearColor];
    
    [self AddHelpLables:innumber];
}
-(int)returenNSStringWidth:(NSString*)text
{
    UIFont * font = [UIFont fontWithName:@"Arial-BoldMT" size:26];
    CGSize stringSize = [text sizeWithFont:font];// 规定字符字体获取字符串Size，再获取其宽度。
    CGFloat width = stringSize.width;
    return width;
}
-(void)AddHelpLables:(NSString*)index
{
    
    
    [self AddStringToLable:NSLocalizedString([@"HelpTitle" stringByAppendingString:index], 
                                             @"View Help") 
                         x:(320 - [self returenNSStringWidth:NSLocalizedString([@"HelpTitle" stringByAppendingString:index], 
                                                     @"View Help")] )/2
                         y:52 
                     width:320
                    height:40
                     color:[UIColor blackColor]
                  fontSize:26
                  fontName:@"Arial-BoldMT"];
    if ([index isEqualToString:@"8"]) 
        [self AddStringToLinkLable:NSLocalizedString([@"HelpBody"  stringByAppendingString:index], 
                                                 @"Demo video") 
                             x:34
                             y:254 
                         width:252
                        height:120
                         color:[UIColor blackColor]
                      fontSize:15
                      fontName:@"Arial"];
        else
    [self AddStringToLable:NSLocalizedString([@"HelpBody"  stringByAppendingString:index], 
                                             @"Demo video") 
                         x:34
                         y:254 
                     width:252
                    height:120
                     color:[UIColor blackColor]
                  fontSize:15
                  fontName:@"Arial"];
}
-(void)AddStringToLable:(NSString*)text x:(int)x y:(int)y width:(int)width height:(int)height color:(UIColor*)color fontSize:(int)fontSize fontName:(NSString*)fontName
{
    UILabel *myLable;
    myLable=[[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [myLable setFont:[UIFont fontWithName:fontName size:fontSize]];
    [myLable setTextColor:color];
    [myLable setNumberOfLines:0];
    [myLable setBackgroundColor:[UIColor clearColor]];
    
    
    //    UIFont *font = [UIFont fontWithName:@"Helvetica" size:15.0];
    //    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(175.0f, 2000.0f) lineBreakMode:UILineBreakModeWordWrap];
    //    CGRect rect=myLable.frame;
    //    rect.size=size;
    //    [myLable setFrame:rect];
    [myLable setText:text];
    [self.view addSubview:myLable];
    [myLable release];
}
#pragma mark ----------------
#pragma mark link lable
-(void)AddStringToLinkLable:(NSString*)text x:(int)x y:(int)y width:(int)width height:(int)height color:(UIColor*)color fontSize:(int)fontSize fontName:(NSString*)fontName
{
    UILabel *myLable;
    myLable=[[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [myLable setFont:[UIFont fontWithName:fontName size:fontSize]];
    [myLable setTextColor:color];
    [myLable setNumberOfLines:0];
    [myLable setBackgroundColor:[UIColor clearColor]];
    [myLable setText:text];
    myLable.tag =  12345;
    myLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =  
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openURL:)] autorelease];  
    [myLable addGestureRecognizer:tapGesture];
    
    [self.view addSubview:myLable];
    [myLable release];
}
-(void)openURL:(UITapGestureRecognizer *)gesture{  
    NSInteger tag = gesture.view.tag;  
    if (tag == 12345) {
        NSString *url = @"http://www.ai-iphone.com";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];  
    }
    
}

-(int)getXCount:(int)x
{
	if (x > 10 && x < 57 ) {
		return 1;
	}else if (x > 60 && x < 106) {
		return 2;
	}else if (x > 110 && x < 157) {
		return 3;
	}else if (x > 162 && x < 208) {
		return 4;
	}else if (x > 214 && x < 259) {
		return 5;
	}else if (x > 263 && x < 309) {
		return 6;
	}
    return 0;
}

-(int)getPointDownIndex:(CGPoint)pointInView
{
	int x = pointInView.x;
	int y = pointInView.y;
	if(y > 1 && y < 48)
	{
		return [self getXCount:x];
	}else if(y > 59 && y < 95)
	{
		return 6+[self getXCount:x];
	}else if(y > 105 && y < 145)
	{
		return 12+[self getXCount:x];
	}
    return 0;
}




@end
