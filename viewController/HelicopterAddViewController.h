//
//  HelicopterAddViewController.h
//  NFSJoystick
//
//  Created by  on 12-4-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSADPE.h"
#import "LSImagesViewController.h"


@interface HelicopterAddViewController : LSImagesViewController<LSBaseProtocolEngineDelegate>
{
    
    
    LSADPE *advertisePE;
}

@end
