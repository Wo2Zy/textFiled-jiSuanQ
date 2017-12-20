//
//  WWTextFiled.h
//  WWTextFiled
//
//  Created by 王威 on 2017/12/20.
//  Copyright © 2017年 WWin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol delegate<NSObject>
@optional
-(void)ansWer:(NSString *)str;
@end
@interface WWTextFiled : UIView
@property(nonatomic,assign)id<delegate>delegate;
@property(nonatomic,copy)NSString *text;
-(void)registerFirstResponsder;
@property(nonatomic,assign)BOOL textIsFirstResponsder;
@end
