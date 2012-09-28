//
//  LSData.m
//  Locoso
//
//  Created by zhiwei ma on 12-3-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSData.h"
#import "LSDefine.h"
#import "SBJson.h"

#pragma mark LSDataCategory
@implementation LSDataCategory
@synthesize ID = _ID;
@synthesize name = _name;
@synthesize spell = _spell;
@synthesize shortname = _shortname;
@synthesize ico = _ico;
@synthesize parentnames = _parentnames;
@synthesize parentids = _parentids;
@synthesize parentid = _parentid;
@synthesize cityname = _cityname;
@synthesize cityid = _cityid;
@synthesize ishot = _ishot;
@synthesize arrchildid = _arrchildid;
@synthesize childnum = _childnum;
@synthesize depth = _depth;
@synthesize childid = _childid;


- (void)dealloc
{
    self.name = nil;
    self.spell = nil;
    self.shortname = nil;
    self.ico = nil;
    self.parentnames = nil;
    self.parentids = nil;
    self.cityname = nil;
    self.arrchildid = nil;
    self.childid = nil;
    [super dealloc];
}


- (BOOL)isTopCategory
{
    return _ID == LSAllWideCategoryID;
}

- (NSString*)fullCategory
{
    return _shortname;
}
@end


//
//LSDataSession
//
#pragma mark LSDataSession
@implementation LSDataSession 
@synthesize uaid = _uaid;
@synthesize session = _session;

- (void)dealloc
{
    self.uaid = nil;
    self.session = nil;
    [super dealloc];
}
@end

#pragma mark LSDataAD
@implementation LSDataAD
@synthesize imageURL = _imageURL;
@synthesize url = _url;
@synthesize webDescriptionUrl = _webDescriptionUrl;
@synthesize whetherOpen = _whetherOpen;
- (void)dealloc
{
    self.imageURL = nil;
    self.url = nil;
    self.webDescriptionUrl = nil;
    [super dealloc];
}
@end



