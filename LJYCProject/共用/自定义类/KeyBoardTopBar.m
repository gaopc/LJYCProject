//
//  KeyBoardTopBar.m
//  KeyBoardTopBar
//
//  Created by 月 小 on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KeyBoardTopBar.h"

@implementation KeyBoardTopBar
@synthesize toolBar,textFields;
@synthesize currentView;
@synthesize currentTextField;
@synthesize prevButtonItem,nextButtonItem,spaceButtonItem,hiddenButtonItem;
- (void)dealloc {

    self.prevButtonItem = nil;
    self.nextButtonItem = nil;
    self.spaceButtonItem = nil;
    self.hiddenButtonItem = nil;
    self.toolBar = nil;
    self.textFields = nil;
    self.currentTextField = nil;
    self.currentView = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


-(id)init:(NSArray*)_textFieldsArray view:(UIView *) view 
{
    if((self = [super init])){
        
//       UIBarButtonItem * _prevButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一项" 
//                                                          style:UIBarButtonItemStyleBordered 
//                                                         target:self 
//                                                         action:@selector(showPrevious)];
//        UIBarButtonItem * _nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一项" 
//                                                          style:UIBarButtonItemStyleBordered 
//                                                         target:self 
//                                                         action:@selector(showNext)];
//        UIBarButtonItem * _hiddenButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"隐藏键盘" 
//                                                            style:UIBarButtonItemStyleBordered 
//                                                           target:self 
//                                                           action:@selector(HiddenKeyBoard)];
//        UIBarButtonItem * _spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
//                                                                        target:nil 
//                                                                        action:nil];
        
        
        
        UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"上一项"  frame:CGRectMake(0, 0, 60, 44) font:[UIFont systemFontOfSize:16 ] color:[UIColor blackColor] target:self action:@selector(showPrevious)];
        [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];

        UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"下一项"  frame:CGRectMake(60, 0, 60, 44) font:[UIFont systemFontOfSize:16 ] color:[UIColor blackColor] target:self action:@selector(showNext)];
        [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        UIButton * button3 = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"隐藏键盘"  frame:CGRectMake(240, 0, 80, 44) font:[UIFont systemFontOfSize:16 ] color:[UIColor blackColor] target:self action:@selector(HiddenKeyBoard)];
        [button3 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button3 setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        
        UIBarButtonItem * _prevButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button1];
        UIBarButtonItem * _nextButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button2];
        UIBarButtonItem * _spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                           target:nil
                                                                                           action:nil];
        UIBarButtonItem * _hiddenButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button3];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HiddenKeyBoard) name:@"hideKeyBoard" object:nil];
        
        self.prevButtonItem = _prevButtonItem;
        self.nextButtonItem = _nextButtonItem;
        self.hiddenButtonItem = _hiddenButtonItem;
        self.spaceButtonItem = _spaceButtonItem;
        
        [_prevButtonItem release];[_nextButtonItem release];[_hiddenButtonItem release];[_spaceButtonItem release];
        
        UIToolbar * _toolBarview = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 600, 320, 44)];
        self.toolBar = _toolBarview;
        [_toolBarview release];
        
        self.toolBar.barStyle = UIBarStyleDefault;
        if ([self.toolBar respondsToSelector:@selector(setBarTintColor:)]) {
            self.toolBar.barTintColor = [UIColor whiteColor];
        }

        self.textFields = _textFieldsArray ;
                    
        self.currentView = view;
        currentTextField = nil;
        
         [self registerForKeyboardNotifications];
        
    }
    return self;
}

-(void)setTextFields:(NSArray *)_textFields
{
    if (textFields != _textFields) {
        [textFields release];
        textFields = nil;
        if (_textFields != nil) {
            textFields = [_textFields retain];
        }
        else {
             return;
        }

        for( id elems in self.textFields){
            if ([elems isKindOfClass:[UITextView class]] ) {
                UITextView * textView = (UITextView *)elems;
                textView.inputAccessoryView = self.toolBar;
            }
            else if( [elems isKindOfClass:[UITextField class]]){
                UITextField * textField = (UITextField *)elems;
                textField.inputAccessoryView = self.toolBar;
            }
        }
        
        if ([self.textFields count] >1) {
            self.toolBar.items = [NSArray arrayWithObjects:self.prevButtonItem,self.nextButtonItem,self.spaceButtonItem,self.hiddenButtonItem, nil];
        }
        else {
            self.toolBar.items = [NSArray arrayWithObjects:self.spaceButtonItem,self.hiddenButtonItem, nil];
        }

    }
}

//显示上一项
-(void)showPrevious{
    if(textFields == nil){
        return;
    }
    NSInteger num = -1;
    for (NSInteger i =0; i<[textFields count]; i++) {
        if([textFields objectAtIndex:i] == currentTextField){
            num = i;
            break;
        }
    }
    if(num>=0){
        [[textFields objectAtIndex:num] resignFirstResponder];
        [[textFields objectAtIndex:num-1] becomeFirstResponder];
        [self showBar:[textFields objectAtIndex:num-1]];
    }
}
//显示下一项
-(void)showNext{
    if(textFields == nil){
        return;
    }
    NSInteger num = -1;
    for (NSInteger i =0; i<[textFields count]; i++) {
        if([textFields objectAtIndex:i] == currentTextField){
            num = i;
            break;
        }
    }
    if(num>=0){
        [[textFields objectAtIndex:num] resignFirstResponder];
        [[textFields objectAtIndex:num+1] becomeFirstResponder];
        [self showBar:[textFields objectAtIndex:num+1]];
    }
}
//显示工具条
-(void)showBar:(UIView *)_textField{
    if ([_textField isKindOfClass:[UITextField class]]) {
        UITextField * textF = (UITextField *) _textField;
        textF.inputAccessoryView = self.toolBar;
    }
    else if ([_textField isKindOfClass:[UITextView class]])
    {
        UITextView * textF = (UITextView *) _textField;
        textF.inputAccessoryView = self.toolBar;
    }
    UIWindow * window = [[(AppDelegate *)[UIApplication sharedApplication] delegate] window] ;
    if (!window.keyWindow) {
        [[[(AppDelegate *)[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
    }
    self.currentTextField = _textField;

    if(_textField == nil){
        self.prevButtonItem.enabled = NO;
        self.nextButtonItem.enabled = NO;
    }
    else {
        NSInteger num = -1;
        for (NSInteger i=0; i<[textFields count]; i++) {
            if ([textFields objectAtIndex:i]==currentTextField) {
                num = i;
                break;
            }
        }
        if (num>0) {
            self.prevButtonItem.enabled = YES;
        }
        else {
            self.prevButtonItem.enabled = NO;
        }
        if (num<[textFields count]-1) {
            self.nextButtonItem.enabled = YES;
        }
        else {
            self.nextButtonItem.enabled = NO;
        }
    }
}
//隐藏键盘和工具条
-(void)HiddenKeyBoard{

   [self.currentTextField resignFirstResponder];

    CGRect frame = self.currentView.frame;
    if (frame.origin.y != 0) 
    {
        frame.origin.y = 0;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:0.3];
        self.currentView.frame = frame;
        [UIView commitAnimations];
    }

}
//键盘遮挡住输入框时，view位置调整
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWasShown:)
												 name:UIKeyboardDidShowNotification object:nil];
	
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWasHidden:)
												 name:UIKeyboardDidHideNotification object:nil];
}

-(void)moveInputBarWithKeyboardHeight:(CGFloat)keybardheight withDuration:(NSTimeInterval)duretion
{
    if (keybardheight == 0) {
        return;
       // [self HiddenKeyBoard];
    }

    CGFloat textField_opposite_Y = self.currentTextField.frame.origin.y+50;

    UIView * textFieldSupperView = self.currentTextField.superview;
    textField_opposite_Y += textFieldSupperView.frame.origin.y;
    
    if ([textFieldSupperView isKindOfClass:[UIScrollView class]]) {
        UIScrollView * view = (UIScrollView *)textFieldSupperView;
        textField_opposite_Y -= view.contentOffset.y;
    }

    while (textFieldSupperView != self.currentView) {
         textFieldSupperView = textFieldSupperView.superview;
         textField_opposite_Y += textFieldSupperView.frame.origin.y;
        if ([textFieldSupperView isKindOfClass:[UITableView class]]) {
            UITableView * view = (UITableView *)textFieldSupperView;
            textField_opposite_Y -= view.contentOffset.y;
        }
        if (textFieldSupperView == nil) {
            break;
        }
    }
    
    if (textField_opposite_Y <0) {
        CGRect frame = self.currentView.frame;
        frame.origin.y =  frame.origin.y -textField_opposite_Y +10;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:duretion];
        self.currentView.frame = frame;
        [UIView commitAnimations];
        return;
    }

    CGFloat viewMoveHeight = textField_opposite_Y + keybardheight +self.toolBar.frame.size.height - self.currentView.frame.size.height;
    if (viewMoveHeight > 0) {
        CGRect frame = self.currentView.frame;
        frame.origin.y -= viewMoveHeight;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:duretion];
        self.currentView.frame = frame;
        [UIView commitAnimations];
    }
}

// UIKeyboardDidShowNotification时调用.
- (void)keyboardWasShown:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    if (animationDurationValue) {
        
        NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardRect = [aValue CGRectValue];
        NSTimeInterval animationDuration = 0;
        [animationDurationValue getValue:&animationDuration];
        [self moveInputBarWithKeyboardHeight:keyboardRect.size.height withDuration:animationDuration];
    }
}

// UIKeyboardDidHideNotification时调用.
- (void)keyboardWasHidden:(NSNotification *)aNotification {
    
//    UILocalNotification *notification=[[UILocalNotification alloc] init];
//    if (notification!=nil) {
//        NSLog(@">> support local notification");
//        NSDate *now=[NSDate new];
//        notification.fireDate=[now addTimeInterval:10];
//        notification.timeZone=[NSTimeZone defaultTimeZone];
//        notification.repeatInterval = kCFCalendarUnitMinute;
//        notification.alertBody=@"该去吃晚饭了！";
//        [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
//        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
//    }
    
//    UIApplication *app = [UIApplication sharedApplication];
//    //获取本地推送数组
//    NSArray *localArr = [app scheduledLocalNotifications];
//    //声明本地通知对象
//    UILocalNotification *localNoti=nil;
//    if (localArr) {
//        for (UILocalNotification *noti in localArr) {
//            //NSDictionary *dict = noti.userInfo;
//            //if (dict)
//            {
//                //NSString *inKey = [dict objectForKey:@"key"];
//                //if ([inKey isEqualToString:Key])
//                {
//                    if (localNoti){
//                        [localNoti release];
//                        localNoti = nil;
//                    }
//                    //localNoti = [noti retain];
//                    [app cancelLocalNotification:noti];
//                    //break;
//                }
//            }
//        }
////        //判断是否找到已经存在的相同key的推送
////        if (!localNoti) {
////            //不存在 初始化
////            localNoti = [[UILocalNotification alloc] init];
////        }
////        if (localNoti) {
////            //不推送 取消推送
////            [app cancelLocalNotification:localNoti];
////            [localNoti release];
////            return;
////        }
//    }
    
    NSDictionary* userInfo = [aNotification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = 0;
    [animationDurationValue getValue:&animationDuration];
//    [self moveInputBarWithKeyboardHeight:0 withDuration:animationDuration];
    if (self.currentView.tag == 100) {
        [self HiddenKeyBoard];
    }
}

@end
