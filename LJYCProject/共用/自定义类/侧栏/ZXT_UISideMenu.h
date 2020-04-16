//
//  ZXT_UISideMenu.h
//  LJYCProject
//
//  Created by 张晓婷 on 13-11-4.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXT_UISideMenu;
@class ZXT_UISideMenuItem;

typedef void (^ZXTUISideItemActionBlock)( ZXT_UISideMenu * menu, ZXT_UISideMenuItem * item );


#pragma mark -


@interface ZXT_UISideMenuItem : NSObject

@property (retain, readwrite, nonatomic) NSString * title;
@property (retain, readwrite, nonatomic) UIImage *  image;
@property (retain, readwrite, nonatomic) UIImage *  highlightedImage;
@property (copy, readwrite, nonatomic) ZXTUISideItemActionBlock action;

- (id)initWithTitle:(NSString *)title action:(ZXTUISideItemActionBlock) action;
- (id)initWithTitle:(NSString *)_title image:(UIImage *)_image highlightedImage:(UIImage *)_highlightedImage action:(ZXTUISideItemActionBlock) _action;
@end

@interface MenuCell : UITableViewCell
@property (retain, nonatomic) UIImageView  * imageV;
@property (retain, nonatomic) UILabel * textLabel;
@end

@interface ZXT_UISideMenu : UIView
@property (retain, nonatomic)  NSArray * items;
@property (assign, nonatomic) CGFloat  verticalOffset;
@property (assign, nonatomic) CGFloat  horizontalOffset;
@property (assign, nonatomic) CGFloat  itemHeight;
@property (retain, nonatomic) UIFont  * font;
@property (retain, nonatomic) UIColor * textColor;
@property (retain, nonatomic) UIColor * highlightedTextColor;
@property (assign, readwrite, nonatomic) BOOL isShowing;

- (id)initWithItems:(NSArray *)items;

- (void)show;
- (void)hide;

@end
