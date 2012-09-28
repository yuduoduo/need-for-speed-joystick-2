//
//  LSADPE.h
//  Locoso
//
//  Created by zhiwei ma on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSBaseProtocolEngine.h"
#import "LSData.h"

@class LSADRspData;
@interface LSADPE : LSBaseProtocolEngine
{
    LSADRspData* _rspData;
}
@property (nonatomic, retain) LSADRspData* rspData;
@end

@interface LSADRspData : NSObject
{
    LSDataAD* _AD;
}
@property (nonatomic, retain) LSDataAD* AD;
@end