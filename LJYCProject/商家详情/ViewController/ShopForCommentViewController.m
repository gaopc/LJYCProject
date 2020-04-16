//
//  ShopForCommentViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-9.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForCommentViewController.h"
#import "ShopForEvaluationViewController.h"
#import "MemberLoginViewController.h"


#define selectColor [UIColor colorWithRed:0x7C/255.0 green:0xD0/255.0 blue:0xEF/255.0 alpha:1];
#define unSelectColor [UIColor colorWithRed:0x29/255.0 green:0xA7/255.0 blue:0xD5/255.0 alpha:1];

@interface ShopForCommentViewController ()

@end

@implementation ShopForCommentViewController
@synthesize _shopId,_shopName;
@synthesize _butHiden;
@synthesize nvBarView;
- (void)dealloc
{
    self._shopId = nil;
    self._shopName = nil;
    self.nvBarView = nil;
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.nvBarView.hidden = NO;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.nvBarView.hidden = YES;
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(70, 0, 180, self.navigationController.navigationBar.frame.size.height)];
    UISubLabel *aLabel = [UISubLabel labelWithTitle:@"查看点评" frame:CGRectMake(0, 0,180, 25) font:FontBlodSize36 color:[UIColor blackColor] alignment:NSTextAlignmentCenter];
    UISubLabel *aLabel2 = [UISubLabel labelWithTitle:self._shopName frame:CGRectMake(0, 22, 180, 20) font:FontSize26 color:[UIColor blackColor] alignment:NSTextAlignmentCenter];
    
    [aLabel setBackgroundColor:[UIColor clearColor]];
    [aLabel2 setBackgroundColor:[UIColor clearColor]];
    [aView setBackgroundColor:[UIColor clearColor]];
    
    [aView addSubview: aLabel];
    [aView addSubview:aLabel2];
    self.nvBarView = aView;
    [aView release];
    [self.navigationController.navigationBar addSubview:self.nvBarView];
    
    
    
    but0 = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"全部" frame:CGRectMake(16, 10, 48, 30) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(change:)];
    but1 = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"5星" frame:CGRectMake(16 + 48, 10, 48, 30) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(change:)];
    but2 = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:@"4星" frame:CGRectMake(16 + 48*2, 10, 48, 30) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(change:)];
    but3 = [UIButton buttonWithType:UIButtonTypeCustom tag:3 title:@"3星" frame:CGRectMake(16 + 48*3, 10, 48, 30) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(change:)];
    but4 = [UIButton buttonWithType:UIButtonTypeCustom tag:4 title:@"2星" frame:CGRectMake(16 + 48*4, 10, 48, 30) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(change:)];
    but5 = [UIButton buttonWithType:UIButtonTypeCustom tag:5 title:@"1星" frame:CGRectMake(16 + 48*5, 10, 48, 30) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(change:)];
    [self setViewForIndex:0];
    
    [self.view_IOS7 addSubview:but0];
    [self.view_IOS7 addSubview:but1];
    [self.view_IOS7 addSubview:but2];
    [self.view_IOS7 addSubview:but3];
    [self.view_IOS7 addSubview:but4];
    [self.view_IOS7 addSubview:but5];
    
    UIButton *rightBut = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(commentClick) title:@"点评"];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
    if (self._butHiden) {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)commentClick
{
    if (NO == [self setUserLogin:ShopForComment]) {
        return;
    }
    ShopForEvaluationViewController *evalueationVC = [[ShopForEvaluationViewController alloc] init];
    evalueationVC._delegate = self;
    evalueationVC._shopId = self._shopId;
    [self.navigationController pushViewController:evalueationVC animated:YES];
    [evalueationVC release];
}

- (void)change:(UIButton *)sender
{
    [self setViewForIndex:sender.tag];
}

- (void)setViewForIndex:(int)index
{
    [self clearCommentView];
    [self setButColor:index];
    
    switch (index) {
        case 0:
            if (!view0) {
                view0 = [self setChangeView:index];
            }
            [self.view_IOS7 addSubview:view0];
            break;
        case 1:
            if (!view1) {
                view1 = [self setChangeView:index];
            }
            [self.view_IOS7 addSubview:view1];
            break;
        case 2:
            if (!view2) {
                view2 = [self setChangeView:index];
            }
            [self.view_IOS7 addSubview:view2];
            break;
        case 3:
            if (!view3) {
                view3 = [self setChangeView:index];
            }
            [self.view_IOS7 addSubview:view3];
            break;
        case 4:
            if (!view4) {
                view4 = [self setChangeView:index];
            }
            [self.view_IOS7 addSubview:view4];
            break;
        case 5:
            if (!view5) {
                view5 = [self setChangeView:index];
            }
            [self.view_IOS7 addSubview:view5];
            break;
            
        default:
            break;
    }
}

- (void)setButColor:(int)index
{
    but0.backgroundColor = unSelectColor;
    but1.backgroundColor = unSelectColor;
    but2.backgroundColor = unSelectColor;
    but3.backgroundColor = unSelectColor;
    but4.backgroundColor = unSelectColor;
    but5.backgroundColor = unSelectColor;
    
    switch (index) {
        case 0:
            but0.backgroundColor = selectColor;
            break;
        case 1:
            but1.backgroundColor = selectColor;
            break;
        case 2:
            but2.backgroundColor = selectColor;
            break;
        case 3:
            but3.backgroundColor = selectColor;
            break;
        case 4:
            but4.backgroundColor = selectColor;
            break;
        case 5:
            but5.backgroundColor = selectColor;
            break;
            
        default:
            break;
    }
}

- (ShopForCommentView *)setChangeView:(NSInteger)buttonIndex
{
    ShopForCommentView *view = [[ShopForCommentView alloc] initWithFrame:CGRectMake(16, 40, 288, ViewHeight - 40 - 44 - 5)];
    view._shopId = self._shopId;
    view._starLv = [NSString stringWithFormat:@"%d", buttonIndex == 0 ? 0 : 6 - buttonIndex];
    [view show];
    return view;
}

- (void)clearCommentView
{
    [view0 removeFromSuperview];
    [view1 removeFromSuperview];
    [view2 removeFromSuperview];
    [view3 removeFromSuperview];
    [view4 removeFromSuperview];
    [view5 removeFromSuperview];
}

- (void)reloadTableView:(NSString *)viewTag
{
    [self setButColor:0];
    [self clearCommentView];
    [view0 show];
    [self.view_IOS7 addSubview:view0];
    
    switch ([viewTag intValue]) {
        case 1:
        {
            if (view5) {
                [view5 show];
            }
            break;
        }
        case 2:
        {
            if (view4) {
                [view4 show];
            }
            break;
        }
        case 3:
        {
            if (view3) {
                [view3 show];
            }
            break;
        }
        case 4:
        {
            if (view2) {
                [view2 show];
            }
            break;
        }
        case 5:
        {
            if (view1) {
                [view1 show];
            }
            break;
        }
        default:
            break;
    }
}

- (BOOL)setUserLogin:(ShopClickType)type
{
    if (![UserLogin sharedUserInfo].userID)
    {
        MemberLoginViewController *memberLoginVC = [[MemberLoginViewController alloc] init];
        memberLoginVC.delegate = self;
        memberLoginVC._clickType = type;
        [self.navigationController pushViewController:memberLoginVC animated:YES];
        [memberLoginVC release];
        return NO;
    }
    return YES;
}

-(void) loginSuccessFul:(ShopClickType)type
{
    if (type == ShopForComment) {
        
        [self commentClick];
    }
}
@end
