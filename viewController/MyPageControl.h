#import <UIKit/UIKit.h>

@interface MyPageControl : UIPageControl
{
        UIImage *imagePageStateNormal;
        UIImage *imagePageStateHighlighted;
}
- (id)initWithFrame:(CGRect)frame;
@property (nonatomic, retain) UIImage *imagePageStateNormal;
@property (nonatomic, retain) UIImage *imagePageStateHighlighted;
@end
