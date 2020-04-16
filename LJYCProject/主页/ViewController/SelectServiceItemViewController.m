//
//  SelectServiceItemViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-5.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "SelectServiceItemViewController.h"
#import "DataClass.h"
#import "MyRegex.h"

@interface SelectServiceItemViewController ()

@end

@implementation SelectServiceItemViewController
@synthesize textFieldArray, keyboardbar;
@synthesize _selectItemArr;
@synthesize _currentArr;
@synthesize _delegate;

- (void)dealloc
{
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    self._selectItemArr = nil;
    self._currentArr = nil;
    self._delegate = nil;
    [saveServiceArr release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"选择服务标签";
    self._currentArr = [[NSArray alloc] init];
    saveServiceArr = [[NSMutableArray alloc] init];
    for (ServiceTag *sTag in self._selectItemArr) {
        [saveServiceArr addObject:sTag];
    }
    
    topViewHeight = 0;
    itemArr1 = [[BaseInfo shareBaseInfo]._ServiceAllTags objectForKey:@"餐饮"];
    itemArr2 = [[BaseInfo shareBaseInfo]._ServiceAllTags objectForKey:@"室内娱乐"];
    itemArr3 = [[BaseInfo shareBaseInfo]._ServiceAllTags objectForKey:@"室外娱乐"];
    itemArr4 = [[BaseInfo shareBaseInfo]._ServiceAllTags objectForKey:@"住宿"];
    itemArr5 = [[BaseInfo shareBaseInfo]._ServiceAllTags objectForKey:@"其他"];
    
    UIButton *rightBut = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(submit) title:@"完成"];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
    midView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, ViewHeight - 44 -5)];
    
    UISubLabel *descriptionLab = [UISubLabel labelWithTitle:@"没有合适的标签？  在下方自定义标签" frame:CGRectMake(15, 0, 200, 30) font:FontSize20 color:FontColorRed alignment:NSTextAlignmentLeft];
    
    UIImageView *textView = [UIImageView ImageViewWithFrame:CGRectMake(15, 25, 200, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    
    myTextField = [UISubTextField TextFieldWithFrame:CGRectMake(25, 25, 190, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"最多可输入五个汉字" font:FontSize24];
    myTextField.delegate = self;
    
    UIButton *submitBut = [CoustomButton buttonWithOrangeColor:CGRectMake(220, 25, 85, 30) target:self action:@selector(newItem) title:@"确认"];
    submitBut.titleLabel.font = FontSize24;
    
    changeBut1 = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"餐饮" backImage:[UIImage imageNamed:@"服务类型-01.png"] frame:CGRectMake(15, 70, 55, 30) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(change:)];
    changeBut2 = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"室内娱乐" backImage:[UIImage imageNamed:@"服务类型-00.png"] frame:CGRectMake(15 + 59, 70, 55, 30) font:FontSize24 color:FontColor000000 target:self action:@selector(change:)];
    changeBut3 = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:@"室外娱乐" backImage:[UIImage imageNamed:@"服务类型-00.png"] frame:CGRectMake(15 + 59*2, 70, 55, 30) font:FontSize24 color:FontColor000000 target:self action:@selector(change:)];
    changeBut4 = [UIButton buttonWithType:UIButtonTypeCustom tag:3 title:@"住宿" backImage:[UIImage imageNamed:@"服务类型-00.png"] frame:CGRectMake(15 + 59*3, 70, 55, 30) font:FontSize24 color:FontColor000000 target:self action:@selector(change:)];
    changeBut5 = [UIButton buttonWithType:UIButtonTypeCustom tag:4 title:@"其它" backImage:[UIImage imageNamed:@"服务类型-00.png"] frame:CGRectMake(15 + 59*4, 70, 55, 30) font:FontSize24 color:FontColor000000 target:self action:@selector(change:)];
    
    UISubLabel *lineView = [UISubLabel labelWithframe:CGRectMake(15, 99, 291, 1) backgroundColor:FontColorRed];

    [self setViewForIndex:0];
    
    [midView addSubview:descriptionLab];
    [midView addSubview:textView];
    [midView addSubview:myTextField];
    [midView addSubview:submitBut];
    [midView addSubview:changeBut1];
    [midView addSubview:changeBut2];
    [midView addSubview:changeBut3];
    [midView addSubview:changeBut4];
    [midView addSubview:changeBut5];
    [midView addSubview:lineView];
    
    [self.view_IOS7 addSubview:midView];
    [midView release];
    
    if ([self._selectItemArr count] != 0) {
        [self setTopView:self._selectItemArr];
    }
    
    self.textFieldArray = [NSArray arrayWithObject:myTextField];
}

- (void)backHome
{
    [self._selectItemArr removeAllObjects];
    for (ServiceTag *sTag in saveServiceArr) {
        [self._selectItemArr addObject:sTag];
    }
    [self.navigationController  popViewControllerAnimated:YES];
}

#pragma mark - textField UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (self.keyboardbar == nil) {
		
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view_IOS7];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
	}
	[keyboardbar showBar:textField];  //显示工具条
	
	return TRUE;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];;
//	
//    if ([[textFieldStr componentsSeparatedByRegex:SHOP_NAME] count] != 0) {
//        return NO;
//    }
//    return YES;
//}

- (void)submit
{
    int serverCount = 0;
    for(ServiceTag *aServiceTag in self._selectItemArr)
    {
        if ([aServiceTag._tag_type intValue] != 10) {
            serverCount ++;
            break;
        }
    }
    if (serverCount == 0) {
        [UIAlertView alertViewWithMessage:@"请至少选择一个系统标签"];
        return;
    }
    
    if (self._delegate && [self._delegate respondsToSelector:@selector(changeServiceType:)]) {
        [self._delegate performSelector:@selector(changeServiceType:) withObject:self._selectItemArr];
    }

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)newItem
{
     NSString *str = myTextField.text;
    if (str.length > 5) {
        
        [UIAlertView alertViewWithMessage:@"自定义标签名称最多为5个汉字"];
        return;
    }
    else if (str.length < 2) {
        
        [UIAlertView alertViewWithMessage:@"自定义标签名称最少为2个汉字"];
        return;
    }
    NSArray *errArr = [str componentsSeparatedByRegex:SHOP_NAME];
    if (errArr.count > 0) {
        [UIAlertView alertViewWithMessage:@"自定义标签名称可以输入汉字、英文、数字"];
        return;
    }
    else if (_selectItemArr.count == 15) {
        [UIAlertView alertViewWithMessage:@"每个店铺最多只能选择15种服务类型"];
        return;
    }
    
    if (str.length > 0) {
        ASIFormDataRequest * theRequest = [InterfaceClass addServiceTag:[UserLogin sharedUserInfo].userID name:str];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredServiceTagResult:) Delegate:self needUserType:Default];
    }
}

- (void)onPaseredServiceTagResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    if (![statusCode isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:message];
        return;
    }
    
    NSString *tagId = [dic objectForKey:@"tagId"];
    ServiceTag *sTag = [ServiceTag serviceNewTagFromElem:[NSArray arrayWithObjects:tagId, myTextField.text, @"10", nil]];
    sTag._tag_index = @"999";
    [self._selectItemArr addObject:sTag];
    [self setTopView:self._selectItemArr];
    
    myTextField.text = @"";
    [keyboardbar HiddenKeyBoard];
}

- (void)itemUnselect:(UIButton *)sender
{
    ServiceTag *sTag = [self._selectItemArr objectAtIndex:sender.tag];
    NSLog(@"stag = %@", sTag._tag_index);
    int viewTag = [sTag._tag_index intValue]/1000;
    
    NSArray *viewArr = [NSArray arrayWithObjects:view1, view2, view3, view4, view5, nil];
    UIButton *selectBut = nil;
    
    if (viewTag >= 1) {
        selectBut = (UIButton *)[[viewArr objectAtIndex:viewTag - 1] viewWithTag:[sTag._tag_index intValue]];
    }
    
    [selectBut setBackgroundImage:nil forState:UIControlStateNormal];
    [selectBut setTitleColor:FontColor656565 forState:UIControlStateNormal];
    
    [self._selectItemArr removeObjectAtIndex:sender.tag];
    [self setTopView:self._selectItemArr];
}

- (void)change:(UIButton *)sender
{
    [self clearButton];
    [sender setBackgroundImage:[UIImage imageNamed:@"服务类型-01.png"] forState:UIControlStateNormal];
    [sender setTitleColor:FontColorFFFFFF forState:UIControlStateNormal];
    [self setViewForIndex:sender.tag];
}

- (void)itemClick:(UIButton *)sender
{
    int copyCount = 0;
    ServiceTag *sTag = [self._currentArr objectAtIndex:sender.tag%1000];
    sTag._tag_index = [NSString stringWithFormat:@"%d", sender.tag];
    
    NSArray *array = self._selectItemArr;
    if ([array count] > 0) {
        for (int i = 0; i < [array count]; i ++) {
            
            ServiceTag *serviceTag = [array objectAtIndex:i];
            if ([serviceTag._tag_name isEqualToString:sTag._tag_name]) {
                [self._selectItemArr removeObject:serviceTag];
                [sender setBackgroundImage:nil forState:UIControlStateNormal];
                [sender setTitleColor:FontColor656565 forState:UIControlStateNormal];
                copyCount ++;
                NSLog(@"标签重复");
            }
        }
    }
    
    if (copyCount == 0) {
        [sender setBackgroundImage:[[UIImage imageNamed:@"添加服务.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:15] forState:UIControlStateNormal];
        [sender setTitleColor:FontColorFFFFFF forState:UIControlStateNormal];
        [self._selectItemArr addObject:sTag];
    }
    
    if ([array count] > 15) {
        [sender setBackgroundImage:nil forState:UIControlStateNormal];
        [sender setTitleColor:FontColor656565 forState:UIControlStateNormal];
        [self._selectItemArr removeLastObject];
        [UIAlertView alertViewWithMessage:@"每个店铺最多只能选择15种服务类型" Title:nil];
        return;
    }
    
    
    [self setTopView:self._selectItemArr];
}

- (void)setViewForIndex:(int)index
{
    [self clearScrollView];
    
    switch (index) {
        case 0:
            if (!view1) {
                view1 = [self setChangeView:0];
            }
            self._currentArr = itemArr1;
            [midView addSubview:view1];
            break;
        case 1:
            if (!view2) {
                view2 = [self setChangeView:1];
            }
            self._currentArr = itemArr2;
            [midView addSubview:view2];
            break;
        case 2:
            if (!view3) {
                view3 = [self setChangeView:2];
            }
            self._currentArr = itemArr3;
            [midView addSubview:view3];
            break;
        case 3:
            if (!view4) {
                view4 = [self setChangeView:3];
            }
            self._currentArr = itemArr4;
            [midView addSubview:view4];
            break;
        case 4:
            if (!view5) {
                view5 = [self setChangeView:4];
            }
            self._currentArr = itemArr5;
            [midView addSubview:view5];
            break;
            
        default:
            break;
    }
}
//myScrollView = [[UIScrollView alloc] init];
//myScrollView.frame = CGRectMake(0, 5, 320, ViewHeight - 44 -5);

- (UIScrollView *)setChangeView:(NSInteger)viewIndex
{
    NSArray *array = nil;
    
    switch (viewIndex) {
        case 0:
            array = itemArr1;
            break;
        case 1:
            array = itemArr2;
            break;
        case 2:
            array = itemArr3;
            break;
        case 3:
            array = itemArr4;
            break;
        case 4:
            array = itemArr5;
            break;
            
        default:
            break;
    }
    
    
    UIScrollView *view = nil;
    int lineNum = 4;
    int itemCount = [array count];
    
    view = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 100, 291, 30*((itemCount - 1)/lineNum) + 40)];
    if (ViewHeight - 100 - 44 < 30*((itemCount - 1)/lineNum) + 20) {
        view.frame = CGRectMake(15, 100, 291, ViewHeight - 100 - 10 - 44);
    }
    
    UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, 291, 30*((itemCount - 1)/lineNum)+ 40) image:[[UIImage imageNamed:@"标签背景.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    [view addSubview:backView];
    
    for (int i = 0; i < itemCount; i ++) {
        
        ServiceTag *sTag = [array objectAtIndex:i];
        UIButton *itemBut = [UIButton buttonWithType:UIButtonTypeCustom tag:(viewIndex + 1)*1000 + i title:sTag._tag_name backImage:nil frame:CGRectMake(i%lineNum*70 + 10, i/lineNum*30 + 10, 65, 25) font:FontSize22 color:FontColor656565 target:self action:@selector(itemClick:)];
        itemBut.titleEdgeInsets = UIEdgeInsetsMake(5, 3, 0, 0);
        for (ServiceTag *selectTag in self._selectItemArr) {
            
            if ([selectTag._tag_name isEqualToString:sTag._tag_name]) {
                
                [itemBut setBackgroundImage:[[UIImage imageNamed:@"添加服务.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:15] forState:UIControlStateNormal];
                [itemBut setTitleColor:FontColorFFFFFF forState:UIControlStateNormal];
            }
        }
        [view addSubview:itemBut];
    }
    
    view.contentSize = CGSizeMake(view.frame.size.width, 30*((itemCount - 1)/lineNum) + 40);
    return view;
}

- (UIView *)setSelectView:(NSArray *)array
{
    UIView *view = [[UIView alloc] init];
    int lineNum = 4;
    int itemCount = [array count];
    if (itemCount == 0) {
        topViewHeight = 0;
    }
    else {
        topViewHeight = ((itemCount -1)/lineNum + 1)*28;
    }
    
    view.frame =CGRectMake(15, 5, 290, 28*((itemCount - 1)/lineNum) + 40);
    
    for (int i = 0; i < itemCount; i ++) {
        
        ServiceTag *sTag = [array objectAtIndex:i];
        UIButton *itemBut = [UIButton buttonWithType:UIButtonTypeCustom tag:i title:sTag._tag_name backImage:[[UIImage imageNamed:@"删除服务.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:5] frame:CGRectMake(i%lineNum*70 + 5, i/lineNum*28 + 5, 65, 25) font:FontSize22 color:FontColorFFFFFF target:self action:@selector(itemUnselect:)];
        itemBut.titleLabel.textAlignment = NSTextAlignmentRight;
        itemBut.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0);
        [view addSubview:itemBut];
    }
    
    return [view autorelease];
}

- (void)clearButton
{
    [changeBut1 setTitleColor:FontColor000000 forState:UIControlStateNormal];
    [changeBut2 setTitleColor:FontColor000000 forState:UIControlStateNormal];
    [changeBut3 setTitleColor:FontColor000000 forState:UIControlStateNormal];
    [changeBut4 setTitleColor:FontColor000000 forState:UIControlStateNormal];
    [changeBut5 setTitleColor:FontColor000000 forState:UIControlStateNormal];
    [changeBut1 setBackgroundImage:[UIImage imageNamed:@"服务类型-00.png"] forState:UIControlStateNormal];
    [changeBut2 setBackgroundImage:[UIImage imageNamed:@"服务类型-00.png"] forState:UIControlStateNormal];
    [changeBut3 setBackgroundImage:[UIImage imageNamed:@"服务类型-00.png"] forState:UIControlStateNormal];
    [changeBut4 setBackgroundImage:[UIImage imageNamed:@"服务类型-00.png"] forState:UIControlStateNormal];
    [changeBut5 setBackgroundImage:[UIImage imageNamed:@"服务类型-00.png"] forState:UIControlStateNormal];
}

- (void)clearScrollView
{
    [view1 removeFromSuperview];
    [view2 removeFromSuperview];
    [view3 removeFromSuperview];
    [view4 removeFromSuperview];
    [view5 removeFromSuperview];
}

- (void)setTopView:(NSArray *)array
{
//    if ([array count] > 1) {
//        ServiceTag *lastObj = [array lastObject];
//        for (int i = 0; i < [array count] - 1; i ++) {
//            
//            ServiceTag *serviceTag = [array objectAtIndex:i];
//            if ([serviceTag._tag_name isEqualToString:lastObj._tag_name]) {
//                [self._selectItemArr removeLastObject];
//                NSLog(@"标签重复");
//            }
//        }
//    }
//    
//    if ([array count] > 15) {
//        [self._selectItemArr removeLastObject];
//        [UIAlertView alertViewWithMessage:@"每个店铺最多只能选择15种服务类型" Title:nil];
//    }
//    else {
//        
//        [topView removeFromSuperview];
//        topView = [self setSelectView:array];
//        [self.view_IOS7 addSubview:topView];
//        
//        [self setViewLayout];
//    }
    
    [topView removeFromSuperview];
    topView = [self setSelectView:array];
    [self.view_IOS7 addSubview:topView];
    
    [self setViewLayout];
}

- (void)setViewLayout
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    CGRect midFrame = midView.frame;
    midFrame.origin.y = topViewHeight + 10;
    midView.frame = midFrame;
    
    view1.frame = [self changeScrollFrame:view1];
    view2.frame = [self changeScrollFrame:view2];
    view3.frame = [self changeScrollFrame:view3];
    view4.frame = [self changeScrollFrame:view4];
    view5.frame = [self changeScrollFrame:view5];
    
    [UIView commitAnimations];
}

- (CGRect)changeScrollFrame:(UIScrollView *)scrllView
{
    int scrllHeight = scrllView.contentSize.height;
    if (topViewHeight + scrllHeight + 110 + 50 > ViewHeight) {
        
        scrllHeight = ViewHeight - topViewHeight - 110 - 54;
    }
    CGRect viewFrame = scrllView.frame;
    viewFrame.size.height = scrllHeight;
    
    return viewFrame;
}

-(NSArray *)getServiceName:(NSString *)typeName
{
    NSArray *typeArr = [[BaseInfo shareBaseInfo]._ServiceAllTags objectForKey:typeName];
    NSMutableArray *array = [NSMutableArray array];//其他
    
    for(ServiceTag *aServiceTag in typeArr)
    {
        
        [array addObject:aServiceTag._tag_name];
    }

    return array;
}

- (void)_setSelectBut
{
    for (int i = 0; i < self._selectItemArr.count; i ++) {
        
        ServiceTag *sTag = [self._selectItemArr objectAtIndex:i];
        NSLog(@"stag = %@", sTag._tag_index);
        int viewTag = [sTag._tag_index intValue]/1000;
        
        NSArray *viewArr = [NSArray arrayWithObjects:view1, view2, view3, view4, view5, nil];
        UIButton *selectBut = nil;
        
        if (viewTag >= 1) {
            selectBut = (UIButton *)[[viewArr objectAtIndex:viewTag - 1] viewWithTag:[sTag._tag_index intValue]];
        }
        
        [selectBut setBackgroundImage:[[UIImage imageNamed:@"添加服务.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:15] forState:UIControlStateNormal];
        [selectBut setTitleColor:FontColorFFFFFF forState:UIControlStateNormal];
    }
}
@end
