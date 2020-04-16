//
//  PhotoData.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-14.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "PhotoData.h"

@implementation PhotoData
@synthesize _photoId, _photoName, _photoType, _image;

- (void)dealloc
{
    self._photoType = nil;
    self._photoName = nil;
    self._photoId = nil;
    self._image = nil;
    [super dealloc];
}

@end
