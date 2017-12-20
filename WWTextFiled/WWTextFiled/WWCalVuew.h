//
//  WWCalVuew.h
//  WWCalView
//
//  Created by 王威 on 2017/12/18.
//  Copyright © 2017年 WWin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface WWCalVuew : UIView
@property (strong, nonatomic) IBOutlet UIView *bgView;
@end
/**********************************使用方法**************************************
 //添加通知
 [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noti:) name:@"love" object:nil];
 // name 必须为love
 // noti.userInfo是内容
 // question 是 等式
 // answer 是答案
*/
