//
//  LSModalView.m
//  Locoso
//
//  Created by zhiwei ma on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSModalView.h"

#pragma mark - LSModalAlertViewDelegate
@interface LSModalAlertViewDelegate : NSObject <UIAlertViewDelegate>  
{  
    CFRunLoopRef _currentLoop;  
    NSUInteger _index;  
}  
@property (readonly) NSUInteger index;  
@end  

@implementation LSModalAlertViewDelegate  
@synthesize index = _index;  

-(id) initWithRunLoop: (CFRunLoopRef)runLoop   
{  
    self = [super init];    
    if (self)
    {
        _currentLoop = runLoop;  
    }
    return self;  
}  

#pragma mark UIAlertViewDelegate
-(void) alertView: (UIAlertView*)aView clickedButtonAtIndex: (NSInteger)anIndex   
{  
    _index = anIndex;  
    CFRunLoopStop(_currentLoop);  
}  
@end  

#pragma mark - LSModalAlertView
@implementation LSModalAlertView
+ (void)messageBox:(NSString*)aTitle message:(NSString*)aMessage
{
      [LSModalAlertView confirmMessageBox:aTitle message:aMessage cancelButtonTitle:nil otherButtonTitle:LSViewUtilsStringConfirm];
}

+ (NSUInteger)confirmMessageBox:(NSString*)aTitle message:(NSString*)aMessage
{
    return  [LSModalAlertView confirmMessageBox:aTitle message:aMessage cancelButtonTitle:LSViewUtilsStringCancel otherButtonTitle:LSViewUtilsStringConfirm];
}

+ (NSUInteger)confirmMessageBox:(NSString*)aTitle message:(NSString*)aMessage cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitles
{
    CFRunLoopRef currentLoop = CFRunLoopGetCurrent();  
    LSModalAlertViewDelegate* madelegate = [[LSModalAlertViewDelegate alloc] initWithRunLoop:currentLoop]; 
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:aTitle message:aMessage delegate:madelegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];  
    [alertView show];  
    
    // Wait for response  
    CFRunLoopRun();  
    
    NSUInteger answer = madelegate.index;  
    [alertView release];  
    [madelegate release];  
    return answer;
}

+ (NSUInteger)selectBox:(NSString*)aTitle message:(NSString*)aMessage cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles,...
{
    CFRunLoopRef currentLoop = CFRunLoopGetCurrent();  
    LSModalAlertViewDelegate* madelegate = [[LSModalAlertViewDelegate alloc] initWithRunLoop:currentLoop]; 
    
    UIAlertView* alertView = nil;
    
    if(otherButtonTitles)
    {
        alertView = [[UIAlertView alloc] initWithTitle:aTitle message:aMessage delegate:madelegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];
        
        NSString* arg;  
        va_list argList;
        NSMutableArray* arrArg = [[[NSMutableArray alloc] initWithCapacity:5] autorelease];
        va_start(argList,otherButtonTitles);  
        while (1)  
        {  
            arg = va_arg(argList,NSString*);
            if (arg)
            {
                [arrArg addObject:arg];
            } 
            else 
            {
                break;
            }
        }  
        va_end(argList);  
        
        for (NSString* title in arrArg)
        {
            [alertView addButtonWithTitle:title];
        }
     }
    else
    {
        alertView = [[UIAlertView alloc] initWithTitle:aTitle message:aMessage delegate:madelegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    }
    [alertView show];  
    
    // Wait for response  
    CFRunLoopRun();  
    
    NSUInteger answer = madelegate.index;  
    [alertView release];  
    [madelegate release];  
    return answer;
}
@end
