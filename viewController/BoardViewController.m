//
//  BoardViewController.m
//  AvatarCreator
//
//  Created by hu yongchang on 7/7/10.
//  Copyright 2010 usa. All rights reserved.
//

#import "BoardViewController.h"
#import "MyViewController.h"
#import "MyPageControl.h"
#import "MsgComm.h"
static NSUInteger kNumberOfPages = 7;
#define NFS_BOTTON_ADD 416
@interface BoardViewController (PrivateMethods)

- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;

@end

@implementation BoardViewController
@synthesize scrollView, pageControl,viewControllers;

//iad
@synthesize bannerIsVisible;
//iAd广告
#ifdef _OPEN_IAD_
@synthesize iAdView;
#endif
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"boardBack.png"]];

    GET_LOCAL_LANGUAGE
    NSLog(@"language %@",currentLanguage);
    
    
    if ([currentLanguage isEqualToString: @"zh-Hans"])
    {
        kNumberOfPages = 8;
    }
    
		[self initPageControl];
    
    bannerIsVisible = NO;
    [self initadvertise];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    bannerView_.delegate = nil;
    
    [bannerView_ release];
   #ifdef _OPEN_IAD_ 
    [iAdView release];
	iAdView = nil;
	#endif
}


- (void)dealloc {

    
	[viewControllers release];
    [scrollView release];
    [pageControl release];
    [super dealloc];
}

-(void)initPageControl
{
	NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    [controllers release];
	
	
	
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
	
//    MyPageControl *pageControl = [[MyPageControl alloc] initWithFrame:CGRectMake(0,360, 320, 30)];
    
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;

	//pageControl.backgroundColor = [UIColor clearColor];
    [pageControl setImagePageStateNormal:[UIImage imageNamed:@"help_page_selected_dot.png"]];
    [pageControl setImagePageStateHighlighted:[UIImage imageNamed:@"help_page_dot.png"]];
//    [self.view addSubview:pageControl];
//    [pageControl release];
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    

}


- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
	
    // replace the placeholder if necessary
    MyViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[MyViewController alloc] initWithPageNumber:page];

        [viewControllers replaceObjectAtIndex:page withObject:controller];
        [controller release];
    }
	//[self.delegate rootChangePageIndex:page];
    // add the controller's view to the scroll view
    if (nil == controller.view.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
		
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
	
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}
-(int)boardChangePageIndex
{
    int page = pageControl.currentPage;
    page = page + 1;
    
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];

    pageControl.currentPage = page;
    return page;
}
- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}

-(void)boardChangeImage:(int)pictureId setPageId:(int)pageId
{
	
}

//change board button
-(void)boardChangeButton:(int)typeId
{
	
	
}

#pragma mark -
#pragma mark init ads
-(void)initadvertise
{
    
    BOOL is_iAdON = NO;
	BOOL is_adMobON = NO;
    
    //分析设备可显示哪一家广告
	if([[[UIDevice currentDevice] model] rangeOfString:@"iPad"].location == 0) {
		is_adMobON = YES;
		if([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.2f) {
			//为iPad 4.2之后的系统显示iAd广告
			//获取当前时区设置
			//NSTimeZone *localTZ = [NSTimeZone localTimeZone];
			//[localTZ name];
			//如果是北美国时间或太平洋时间，则假想是美国用户
			//2010.12 英国，法国
			//2011.1  德国
			//2011.?  日本
			if([[[NSTimeZone localTimeZone] name] rangeOfString:@"America/"].location == 0
			   || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Pacific/"].location == 0
			   || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Europe/"].location == 0
			   || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Tokyo"].location == 0)
			{
				is_adMobON = NO;
			}
		}
	}
	else if([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0f) {
		//获取当前时区设置
		//NSTimeZone *localTZ = [NSTimeZone localTimeZone];
		//[localTZ name];
		//如果是北美国时间或太平洋时间，则假想是美国用户
		//2010.12 英国，法国
		//2011.1  德国
		//2011.?  日本
		if([[[NSTimeZone localTimeZone] name] rangeOfString:@"America/"].location == 0
		   || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Pacific/"].location == 0
		   || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Europe/"].location == 0
		   || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Tokyo"].location == 0)
		{
			is_adMobON = NO;
		}
		else
			is_adMobON = YES;
	}
	else{
		is_adMobON = YES;
	}
	if(!is_adMobON){
		is_iAdON = YES;
    }
    
    if (is_iAdON) 
    {
        [self initIAD];
    }
    else
    {
        [self initAdmob];
    }

}
-(void)initAdmob
{
    // Create a view of the standard size at the bottom of the screen.
    bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                                            0,
                                            GAD_SIZE_320x50.width,
                                            GAD_SIZE_320x50.height)];
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    bannerView_.adUnitID = MY_BANNER_UNIT_ID;
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    // [iadController.view addSubview:bannerView_];
    [self.view addSubview:bannerView_];
    [bannerView_ setDelegate:self];
    
    GADRequest *request = [GADRequest request];
    //    request.testing = YES;
    //       request.testDevices = [NSArray arrayWithObjects:
    //           GAD_SIMULATOR_ID,                               // Simulator
    //           @"51707abcdde264d0d12d00624d913af91ed60469",  // Test iPhone 3G 3.0.1
    //           nil];
    //    request.gender = kGADGenderMale;
    //    [request addKeyword:@"game"];
    //    [request setLocationWithLatitude:locationManager_.location.coordinate.latitude
    //                           longitude:locationManager_.location.coordinate.longitude
    //                            accuracy:locationManager_.location.horizontalAccuracy];
    //[request setLocationWithDescription:@"US"];
    // Initiate a generic request to load it with an ad.
    [bannerView_ loadRequest:request];	
}

-(void)initIAD
{
    #ifdef _OPEN_IAD_
    iAdView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    iAdView.requiredContentSizeIdentifiers = [NSSet setWithObject: ADBannerContentSizeIdentifierPortrait];
    iAdView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    
    if([[[UIDevice currentDevice] model] rangeOfString:@"iPad"].location == 0)
        iAdView.frame = CGRectMake(0, -66, 768, 66);				
    else
        iAdView.frame = CGRectMake(0, -50, 320, 50);
    
    iAdView.delegate = self;
    [self.view addSubview:iAdView];
    #endif
}

#pragma mark -
#pragma mark Apple Iad action
//- (UIViewController *)viewControllerForModalPresentation:
//(GADAdViewController *)adController {
//	return self;
//}


#pragma mark -
#pragma mark google admob

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    [UIView beginAnimations:@"BannerSlide" context:nil];
    bannerView.frame = CGRectMake(0.0,
                                  NFS_BOTTON_ADD-GAD_SIZE_320x50.height,
                                  GAD_SIZE_320x50.width,
                                  GAD_SIZE_320x50.height);
    [UIView commitAnimations];
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    [bannerView_ removeFromSuperview];
    [bannerView_ release];
    bannerView_ = nil;
    //试试iAd
	[self tryiAdWhenAdMobFailed];
    
    NSLog(@"error:%@",[error localizedDescription]);
}
#pragma mark -
#pragma mark apple IAD

//成功加载广告
#ifdef _OPEN_IAD_
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    NSLog(@"[iAd]: 广告已经加载.");
    if (!self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
		if([[[UIDevice currentDevice] model] rangeOfString:@"iPad"].location == 0)
			banner.frame = CGRectOffset(banner.frame, 0, NFS_BOTTON_ADD);
		else
			banner.frame = CGRectOffset(banner.frame, 0, NFS_BOTTON_ADD);
		bannerIsVisible = YES;
        [UIView commitAnimations];
    }
}

//加载广告失败
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"[iAd]: 加载广告失败: %@", [error localizedDescription]);	
    if (self.bannerIsVisible)	
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
		// assumes the banner view is at the top of the screen.
		if([[[UIDevice currentDevice] model] rangeOfString:@"iPad"].location == 0)
			banner.frame = CGRectOffset(banner.frame, 0, -NFS_BOTTON_ADD);
		else
			banner.frame = CGRectOffset(banner.frame, 0, -NFS_BOTTON_ADD);
		
        [UIView commitAnimations];
        bannerIsVisible = NO;
        
        
        [iAdView removeFromSuperview];
        [iAdView release];
        iAdView = nil;
    }   
    [self initAdmob];
}
#endif
- (void)tryiAdWhenAdMobFailed {
	BOOL is_iAdON = NO;
	//当AdMob请示失败时，则说明AdMob暂未获得广告，此时查看4.0以上的系统，看看是否支持iAd
	if([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0f) {
		if([[[UIDevice currentDevice] model] rangeOfString:@"iPad"].location == 0) {
            if([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.2f)
                is_iAdON = YES;
		}
		else
			is_iAdON = YES;
	}
    
	//打开广告
	if(is_iAdON) {
		//启用iAd
		#ifdef _OPEN_IAD_
		if(!iAdView) {
			iAdView = [[ADBannerView alloc] initWithFrame:CGRectZero];
			iAdView.requiredContentSizeIdentifiers = [NSSet setWithObject: ADBannerContentSizeIdentifierPortrait];
			iAdView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
			
			if([[[UIDevice currentDevice] model] rangeOfString:@"iPad"].location == 0)
				iAdView.frame = CGRectMake(0, NFS_BOTTON_ADD-66, 768, 66);				
			else
				iAdView.frame = CGRectMake(0, NFS_BOTTON_ADD-50, 320, 50);
			
			iAdView.delegate = self;
			[self.view addSubview:iAdView];
			
		}	
		#endif
	}
}

@end
