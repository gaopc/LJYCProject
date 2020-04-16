//
//  RootView.h
//  LJYCProject
//
//  Created by 张晓婷 on 13-10-24.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootView : UIView
@property (nonatomic,assign) id _delegate;
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
