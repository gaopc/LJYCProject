//
//  ActivetyShopCell.m
//  LJYCProject
//
//  Created by gaopengcheng on 15-6-16.
//  Copyright (c) 2015年 longcd. All rights reserved.
//

#import "ActivetyShopCell.h"

@implementation ActivetyShopCell
@synthesize _imageV,_nameLab,_addressLab;

- (void)dealloc
{
    self._imageV = nil;
    self._nameLab = nil;
    self._addressLab = nil;
    
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat height = 100;
        
        self._imageV = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, height)];
        self._imageV.defaultImage = 3;
        
        self._nameLab = [UISubLabel labelWithTitle:@"怀柔采摘园" frame:CGRectMake(10,height - 30,(ViewWidth - 20)/2,30) font:[UIFont systemFontOfSize:14] color:[UIColor whiteColor] alignment:NSTextAlignmentLeft autoSize:NO];
        self._addressLab = [UISubLabel labelWithTitle:@"怀柔区怀柔镇军庄村北100米" frame:CGRectMake(10+(ViewWidth - 20)/2,height - 30,(ViewWidth - 20)/2,30) font:[UIFont systemFontOfSize:12] color:[UIColor whiteColor] alignment:NSTextAlignmentLeft autoSize:NO];
        
        [self addSubview:self._imageV];
        [self addSubview:self._nameLab];
        [self addSubview:self._addressLab];
        
    }
    return self;
}
@end
