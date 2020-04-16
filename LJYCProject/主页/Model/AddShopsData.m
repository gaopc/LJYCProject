//
//  AddShopsData.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-11.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "AddShopsData.h"

@implementation AddShopsData
@synthesize _userId, _type, _telephone, _serviceTagId, _scale, _picType, _picId, _notice;
@synthesize _longitude, _latitude, _introduce, _district, _cycleStart, _cycleEnd, _cityName, _address, _name;
@synthesize _otherServiewTagId;

- (void)dealloc
{
    self._name = nil;
    self._address = nil;
    self._cityName = nil;
    self._cycleEnd = nil;
    self._cycleStart = nil;
    self._district = nil;
    self._introduce = nil;
    self._latitude = nil;
    self._longitude = nil;
    self._notice = nil;
    self._picId = nil;
    self._picType = nil;
    self._scale = nil;
    self._serviceTagId = nil;
    self._telephone = nil;
    self._type = nil;
    self._userId = nil;
    self._otherServiewTagId = nil;
    [super dealloc];
}

@end
