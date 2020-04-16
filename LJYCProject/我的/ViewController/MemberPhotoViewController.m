//
//  MemberPhotoViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "MemberPhotoViewController.h"
#import "MemberPhotoDetailViewController.h"
#define LEISHU 2;
#define selectColor [UIColor colorWithRed:0x7C/255.0 green:0xD0/255.0 blue:0xEF/255.0 alpha:1];
#define unSelectColor [UIColor colorWithRed:0x29/255.0 green:0xA7/255.0 blue:0xD5/255.0 alpha:1];

@interface MemberPhotoViewController ()

@end

@implementation MemberPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"商家照片";
    
//    imgArr = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"休业.png"], [UIImage imageNamed:@"停业.png"], [UIImage imageNamed:@"休业.png"], [UIImage imageNamed:@"停业.png"], [UIImage imageNamed:@"休业.png"], [UIImage imageNamed:@"停业.png"], [UIImage imageNamed:@"休业.png"], [UIImage imageNamed:@"停业.png"], nil];
    
    but1 = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"环境" frame:CGRectMake(20, 10, 70, 27) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(photoType:)];
    but2 = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"住宿" frame:CGRectMake(20 + 70, 10, 70, 27) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(photoType:)];
    but3 = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:@"餐饮" frame:CGRectMake(20 + 70*2, 10, 70, 27) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(photoType:)];
    but4 = [UIButton buttonWithType:UIButtonTypeCustom tag:3 title:@"其它" frame:CGRectMake(20 + 70*3, 10, 70, 27) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(photoType:)];
    
    UIImageView *line = [UIImageView ImageViewWithFrame:CGRectMake(25, 47, 270, 1) image:[UIImage imageNamed:@"横向分割线.png"]];
    
    [self selectPhotoTpye:0];
    
    [self.view_IOS7 addSubview:but1];
    [self.view_IOS7 addSubview:but2];
    [self.view_IOS7 addSubview:but3];
    [self.view_IOS7 addSubview:but4];
    [self.view_IOS7 addSubview:line];
}

#pragma mark - LLWaterFlowViewDelegate
- (NSUInteger)numberOfColumnsInFlowView:(LLWaterFlowView *)flowView
{
	return LEISHU;
}
- (NSInteger)flowView:(LLWaterFlowView *)flowView numberOfRowsInColumn:(NSInteger)column
{
	return  ([imgArr count] + 1)/2;
}
-(void)numImage:(UIButton*)button
{
    NSLog(@"点击图片第%d个。。。",button.tag);
    NSString *lineNum = [[NSString stringWithFormat:@"%d", button.tag] substringToIndex:1];
    int arrayIndex = 0;
    
    switch ([lineNum intValue]) {
        case 1:
            arrayIndex = [[[NSString stringWithFormat:@"%d", button.tag] substringFromIndex:1] intValue];
            break;
        case 2:
            arrayIndex = [[[NSString stringWithFormat:@"%d", button.tag] substringFromIndex:1] intValue] + ([imgArr count] + 1)/2;
            break;
        default:
            break;
    }
    
    NSLog(@"arrayIndex : %d", arrayIndex);
    MemberPhotoDetailViewController *detailVC = [[MemberPhotoDetailViewController alloc] init];
    detailVC._picArray = imgArr;
    detailVC._picIndex = [NSString stringWithFormat:@"%d", arrayIndex];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}
- (LLWaterFlowCell *)flowView:(LLWaterFlowView *)flowView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath tableviewTAG:(int)tableviewTag
{
    NSString *tag1 = [NSString stringWithFormat:@"%d%d",tableviewTag+1,indexPath.row];

    NSString *CellIdentifier = [NSString stringWithFormat:@"CellTag_Airport_weather%@",tag1];
	LLWaterFlowCell *cell = [flowView_ dequeueReusableCellWithIdentifier:CellIdentifier];
    float hei = [self flowView:nil heightForRowAtIndexPath:indexPath];

	if(cell == nil)
	{
		cell  = [[[LLWaterFlowCell alloc] initWithIdentifier:CellIdentifier] init];

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = [tag1 intValue];
        [btn addTarget:self action:@selector(numImage:) forControlEvents:UIControlEventTouchUpInside];


        [cell addSubview:btn];
        btn.layer.borderColor = [[UIColor whiteColor] CGColor];
        btn.layer.borderWidth = 4;



		UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.backgroundColor = [UIColor clearColor];
		[cell addSubview:label];
        label.tag = 102;
		label.textAlignment = UITextAlignmentCenter;
		label.font = [UIFont boldSystemFontOfSize:30];
		label.shadowOffset = CGSizeMake(0, 1);
		label.shadowColor = [UIColor redColor];
		label.textColor = [UIColor whiteColor];

	}

	else
	{
		NSLog(@"此条是从重用列表中获取的。。。。。");
	}



    float wi = 260/LEISHU;
    int index = indexPath.section*([imgArr count] + 1)/2 + indexPath.row;
    NSLog(@"row = %d", indexPath.row);
    NSLog(@"section = %d", indexPath.section);
    NSLog(@"index = %d", index);
    
    if (index < [imgArr count]) {
        UIButton *btn = (UIButton*)[cell viewWithTag:[tag1 intValue]];
        btn.frame = CGRectMake(2, 1, wi, hei - 10);
        UIImage *image = [imgArr objectAtIndex:index];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
    }

	UILabel *label = (UILabel *)[cell viewWithTag:102];
	label.frame = CGRectMake(0, 0, wi, hei - 10);
	label.text = [NSString stringWithFormat:@"%@", tag1];

	return cell;
}

- (CGFloat)flowView:(LLWaterFlowView *)flowView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 100;
}

#pragma mark - self
- (void)photoType:(UIButton *)sender
{
    [self selectPhotoTpye:sender.tag];

}

- (void)selectPhotoTpye:(int)index
{
    [self setButColor:index];
    
    [flowView1 removeFromSuperview];
    [flowView3 removeFromSuperview];
    [flowView4 removeFromSuperview];
    [flowView2 removeFromSuperview];
    
    switch (index) {
        case 0:
            if (!flowView1) {
                flowView1 = [self setWaterFlowView:[NSArray arrayWithObjects:@"", nil]];
            }
            [self.view_IOS7 addSubview:flowView1];
            break;
            
        case 1:
            if (!flowView2) {
                flowView2 = [self setWaterFlowView:[NSArray arrayWithObjects:@"", nil]];
            }
            [self.view_IOS7 addSubview:flowView2];
            break;
            
        case 2:
            if (!flowView3) {
                flowView3 = [self setWaterFlowView:[NSArray arrayWithObjects:@"", nil]];
            }
            [self.view_IOS7 addSubview:flowView3];
            break;
            
        case 3:
            if (!flowView4) {
                flowView4 = [self setWaterFlowView:[NSArray arrayWithObjects:@"", nil]];
            }
            [self.view_IOS7 addSubview:flowView4];
            break;
            
        default:
            break;
    }
}

- (void)setButColor:(int)index
{
    but1.backgroundColor = unSelectColor;
    but2.backgroundColor = unSelectColor;
    but3.backgroundColor = unSelectColor;
    but4.backgroundColor = unSelectColor;
    
    switch (index) {
        case 0:
            but1.backgroundColor = selectColor;
            break;
        case 1:
            but2.backgroundColor = selectColor;
            break;
        case 2:
            but3.backgroundColor = selectColor;
            break;
        case 3:
            but4.backgroundColor = selectColor;
            break;
            
        default:
            break;
    }
}

- (LLWaterFlowView *)setWaterFlowView:(NSArray *)array
{
    LLWaterFlowView *view = [[LLWaterFlowView alloc] initWithFrame:CGRectMake(20, 57, ViewWidth - 40, ViewHeight - 45 - 60)];
	view.flowdelegate = self;
	view.backgroundColor = [UIColor clearColor];
    
    return view;
}

@end
