//
//  BoardViewController.h
//  AvatarCreator
//
//  Created by hu yongchang on 7/7/10.
//  Copyright 2010 usa. All rights reserved.
//
#define _OPEN_IAD_ 1

#import <UIKit/UIKit.h>
#import "MyViewController.h"
#ifdef _OPEN_IAD_
#import <iAd/iAd.h>
#endif
//
#import "GADBannerViewDelegate.h"

#import "GADBannerView.h"
#define MY_BANNER_UNIT_ID @"a14fdefaa2436f8"



@class MyPageControl;
@interface BoardViewController : UIViewController <UIScrollViewDelegate
#ifdef _OPEN_IAD_
,ADBannerViewDelegate
#endif
,GADBannerViewDelegate>{
	UIScrollView *scrollView;
    IBOutlet MyPageControl *pageControl;
    NSMutableArray *viewControllers;
	
    // To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;

    
    //admob
	GADBannerView *bannerView_;
    //Ads
	#ifdef _OPEN_IAD_
	ADBannerView *iAdView;
	#endif
    BOOL bannerIsVisible;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet MyPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;
//iAd广告
#ifdef _OPEN_IAD_
@property(nonatomic,retain) ADBannerView *iAdView;
#endif
@property (nonatomic) BOOL bannerIsVisible;

- (IBAction)changePage:(id)sender;

- (void)tryiAdWhenAdMobFailed;
-(void)initPageControl;
-(void)initadvertise;
-(void)initIAD;
-(int)boardChangePageIndex;
@end
