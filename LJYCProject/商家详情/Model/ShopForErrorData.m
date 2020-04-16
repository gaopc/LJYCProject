//
//  ShopForErrorData.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-12.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForErrorData.h"

@implementation ShopForErrorData
@synthesize _address, _district, _email, _name, _phone, _shopId, _telephone, _type, _userId, _content;

-(void)dealloc
{
    self._address = nil;
    self._district = nil;
    self._email = nil;
    self._name = nil;
    self._phone = nil;
    self._shopId = nil;
    self._telephone = nil;
    self._type = nil;
    self._userId = nil;
    self._content = nil;
    [super dealloc];
}
@end
