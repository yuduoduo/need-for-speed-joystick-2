//
//  LSData.h
//  Locoso
//
//  Created by zhiwei ma on 12-3-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#define LSCountryWideCityID         10000
#define LSAllWideCategoryID         20000

//
//LSDataCategory
//
@interface LSDataCategory : NSObject
{
    long            _ID;
    NSString*       _name;
    NSString*       _spell;
    NSString*       _shortname;
    NSString*       _ico;
    NSString*       _parentnames;
    NSString*       _parentids;
    long            _parentid;
    NSString*       _cityname;
    long            _cityid;
    NSInteger       _ishot;
    NSString*       _arrchildid;
    NSInteger       _childnum;
    NSInteger       _depth;
    NSString*       _childid;
}
@property (nonatomic) long ID;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* spell;
@property (nonatomic, retain) NSString* shortname;
@property (nonatomic, retain) NSString* ico;
@property (nonatomic, retain) NSString* parentnames;
@property (nonatomic, retain) NSString* parentids;
@property (nonatomic) long parentid;
@property (nonatomic, retain) NSString* cityname;
@property (nonatomic) long cityid;
@property (nonatomic) NSInteger ishot;
@property (nonatomic, retain) NSString* arrchildid;
@property (nonatomic) NSInteger childnum;
@property (nonatomic) NSInteger depth;
@property (nonatomic, retain) NSString* childid;

+ (LSDataCategory*)allWideCategory;
- (BOOL)isTopCategory;
- (NSString*)fullCategory;
@end

//
//LSDataCompany
//
@interface LSDataCompany : NSObject
{
    long            _companyID;
    NSString*       _companyName;
    NSString*       _logo;
    NSString*       _address;
    NSString*       _area;
    NSString*       _city;
    NSString*       _province;
    NSInteger       _state;//认证状态

}
@property (nonatomic) long companyID;
@property (nonatomic, retain) NSString* companyName;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSString* address;
@property (nonatomic, retain) NSString* area;
@property (nonatomic, retain) NSString* city;
@property (nonatomic, retain) NSString* province;
@property (nonatomic) NSInteger state;
- (NSString*)fullAddress;
- (NSString*)jsonString;
@end

//
//LSDataCompanyDetail
@interface LSDataCompanyDetail : LSDataCompany
{
    NSString*       _telephone;
    NSString*       _mapx;
    NSString*       _mapy;
    NSString*       _homepage;
    NSString*       _siteurl;
    NSString*       _info;
    NSString*       _contactpeople;
    NSString*       _contactphone;
    NSString*       _email;
    NSString*       _product;
    long            _siteid;
    NSString*       _icname;
    NSString*       _icaddress;
    NSString*       _icbusiness;

}
@property (nonatomic, retain) NSString*       contactphone;
@property (nonatomic, retain) NSString*       mapx;
@property (nonatomic, retain) NSString*       mapy;
@property (nonatomic, retain) NSString*         info;
@property (nonatomic, retain) NSString*         product;
@end

//
//LSDataProduct
//
@interface LSDataProduct : NSObject
{
    long            _producid;
    NSString*       _productname;
    NSString*       _summary;
    NSString*       _content;
    NSString*       _imageUrl;
}
@property (nonatomic) long producid;
@property (nonatomic, retain) NSString* productname;
@property (nonatomic, retain) NSString* imageUrl;
@property (nonatomic, retain) NSString* summary;
//@property (nonatomic, retain) NSString* content;
@end

//
//LSDataCount
//
@interface LSDataCount : NSObject
{

    NSString*       photocount;
    NSString*       mesgcount;
    NSString*       viewCount;
    NSString*       procount;
    NSString*       newscount;
}

@property (nonatomic, retain) NSString* photocount;
@property (nonatomic, retain) NSString* mesgcount;
@property (nonatomic, retain) NSString* viewCount;
@property (nonatomic, retain) NSString* procount;
@property (nonatomic, retain) NSString* newscount;
@end
//
//LSDataNews
//
@interface LSDataNews : NSObject
{
    long _articleid;
    NSString* _title;
    NSString* _content;
}
@property (nonatomic) long articleid;
@property (nonatomic, retain) NSString* title;
@property (nonatomic,retain) NSString* content;
@end

//
//LSDataMessage
//
@interface LSDataMessage : NSObject
{
    long _messageID;
    long _senderuaid;
    NSString* _senderuaname;
    NSString* _conent;
    NSString* _createtime;
    NSString* _replyContent;
    NSInteger _state;
}
@property (nonatomic) long messageID;
@property (nonatomic) long senderuaid;
@property (nonatomic) NSInteger state;
@property (nonatomic, retain) NSString* senderuaname;
@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* createtime;
@property (nonatomic, retain) NSString* replyContent;
@end

//
//LSDataPhoto
//
@interface LSDataPhoto : NSObject
{
    long _mediaid;
    NSString* _medianame;
    NSString* _filepath;
}
@property (nonatomic) long mediaid;
@property (nonatomic, retain) NSString* medianame;
@property (nonatomic, retain) NSString* filepath;
@end

//
//LSDataCity
//
@interface LSDataCity : NSObject
{
    long _ID;
    NSString* _shortname;
    NSInteger _childnum;
    NSInteger _depth;
    long _parentid;
    NSString* _parentnames;
}
@property (nonatomic) long ID;
@property (nonatomic, retain) NSString* shortname;
@property (nonatomic) NSInteger childnum;
@property (nonatomic) NSInteger depth;
@property (nonatomic) long parentid;
@property (nonatomic, retain) NSString* parentnames;
+ (LSDataCity*)countryWideCity;
- (BOOL)isTopCity;
- (NSString*)fullArea;
@end

//
//LSDataEnterprise
@interface LSDataEnterprise : NSObject
{
    NSString*       _telephone;
    NSString*       _contactpeople;
    NSString*       _contactphone;
    NSString*       _companyname;
    NSString*       _address;
    NSString*       _mobilephone;
    NSString*       _email;
    NSString*       _website;
    NSString*       _city;
    NSString*       _catename;
    NSString*       _logo;
    NSInteger       _state;
}
@property (nonatomic, retain) NSString*       telephone;
@property (nonatomic, retain) NSString*       contactpeople;
@property (nonatomic, retain) NSString*       contactphone;
@property (nonatomic, retain) NSString*       companyname;
@property (nonatomic, retain) NSString*       address;
@property (nonatomic, retain) NSString*       mobilephone;
@property (nonatomic, retain) NSString*       email;
@property (nonatomic, retain) NSString*       website;
@property (nonatomic, retain) NSString*       city;
@property (nonatomic, retain) NSString*       catename;
@property (nonatomic, retain) NSString*       logo;
@property (nonatomic) NSInteger state;
@end

//
//LSDataKeyowrd
//
@interface LSDataKeyword : NSObject
{
    NSString* _name;
    NSInteger _count;
}
@property (nonatomic, retain) NSString* name;
@property (nonatomic) NSInteger count;
@end

//
//LSDataSession
//
@interface LSDataSession : NSObject
{
    NSString* _uaid;
    NSString* _session;
}
@property (nonatomic, retain) NSString* uaid;
@property (nonatomic, retain) NSString* session;
@end

//
//LSDataAD
//
@interface LSDataAD : NSObject
{
    NSString* _imageURL;
    NSString* _url;
}
@property (nonatomic, retain) NSString* imageURL;
@property (nonatomic, retain) NSString* url;
@property (nonatomic, retain) NSString*webDescriptionUrl;
@property (nonatomic) BOOL whetherOpen;
@end

//
//NSString (LSDataCompany)
//
@interface NSString (LSDataCompany)
- (LSDataCompany*)company;
@end