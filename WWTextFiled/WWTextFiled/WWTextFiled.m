//
//  WWTextFiled.m
//  WWTextFiled
//
//  Created by 王威 on 2017/12/20.
//  Copyright © 2017年 WWin. All rights reserved.
//

#import "WWTextFiled.h"
#import <UIKit/UIKit.h>
#import "WWCalVuew.h"
@interface WWTextFiled()
@property(nonatomic,strong)WWCalVuew *keyBoard;
@property(nonatomic,strong)UILabel *textLabel;
@property(nonatomic,strong)UIView *zhiZhenView;
@property(nonatomic,strong)UITapGestureRecognizer *ges;
@end
@implementation WWTextFiled
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = true;
    self.layer.borderWidth = .5f;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:self.textLabel];
    [self addSubview:self.zhiZhenView];
    [self addGestureRecognizer:self.ges];
}
-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 0, self.frame.size.height - 4)];
        _textLabel.font = [UIFont systemFontOfSize:15.0f];
        _textLabel.textColor = [UIColor blackColor];
    }
    return _textLabel;
}
-(UIView *)zhiZhenView{
    if (!_zhiZhenView) {
        _zhiZhenView = [[UIView alloc]initWithFrame:CGRectMake(self.textLabel.frame.origin.x+self.textLabel.frame.size.width + 2, 2, 1, self.frame.size.height - 4)];
        _zhiZhenView.alpha = 0;
        self.textIsFirstResponsder = NO;
        _zhiZhenView.backgroundColor = [UIColor blackColor];
    }
    return _zhiZhenView;
}
-(UITapGestureRecognizer *)ges{
    if (!_ges) {
        _ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(animation)];
    }
    return _ges;
}
-(void)registerFirstResponsder{
    if (self.textIsFirstResponsder == YES) {
        [self dissMiss];
    }
    self.textIsFirstResponsder = NO;
    [self.zhiZhenView.layer removeAllAnimations];
}
-(void)dissMiss{
    [UIView animateWithDuration:1.0 animations:^{
        self.keyBoard.transform = CGAffineTransformIdentity;
    }];
}
-(void)setText:(NSString *)text{
    if (!_text) {
        _text = @"";
    }
    if (self.textIsFirstResponsder == YES) {
        _text = text;
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:_text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f],NSForegroundColorAttributeName:[UIColor blackColor]}];
        CGSize size = [str size];
        CGRect frame = self.textLabel.frame;
        frame.size.width = size.width;
        self.textLabel.frame = frame;
        self.textLabel.attributedText = str;
        CGRect frame1 = self.zhiZhenView.frame;
        frame1.origin.x = frame.origin.x + frame.size.width + 2;
        self.zhiZhenView.frame = frame1;
        if (frame.size.width + 7 > self.frame.size.width) {
            [UIView animateWithDuration:0.8 animations:^{
                self.textLabel.transform =  CGAffineTransformMakeTranslation(-(frame.size.width + 13 - self.frame.size.width), 0);
                self.zhiZhenView.transform = CGAffineTransformMakeTranslation(-(frame.size.width + 13 - self.frame.size.width), 0);
            }];
        }else{
            [UIView animateWithDuration:0.8 animations:^{
                self.textLabel.transform = CGAffineTransformIdentity;
                self.zhiZhenView.transform = CGAffineTransformIdentity;
            }];
        }
    }
}
-(void)animation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.zhiZhenView.layer addAnimation:animation forKey:nil];
    if (self.textIsFirstResponsder == NO) {
        [self showKeyBoard];
    }
    self.textIsFirstResponsder = YES;
}
-(void)showKeyBoard{
      [[[[UIApplication sharedApplication] delegate]window].rootViewController.view addSubview:self.keyBoard];
    [UIView animateWithDuration:1 animations:^{
        self.keyBoard.transform = CGAffineTransformMakeTranslation(0, -[UIScreen mainScreen].bounds.size.height/2);
    }];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(WWCalVuew *)keyBoard{
    if (!_keyBoard) {
        _keyBoard = [[WWCalVuew alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2)];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noti:) name:@"love" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(souDong) name:@"douDong" object:nil];
    }
    return _keyBoard;
}
-(void)souDong{
    CAKeyframeAnimation *shake=[CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    shake.values=@[@0,@-10,@10,@-10,@0];
    shake.additive=YES;
    shake.duration=0.25;
    [self.textLabel.layer addAnimation:shake forKey:@"shake"];
}
-(void)noti:(NSNotification *)noti{
    NSDictionary *dicc = noti.userInfo;
    self.text = [dicc objectForKey:@"question"];
    [self.delegate ansWer:[dicc objectForKey:@"answer"]];
}
-(void)layoutSubviews{
    
}
@end
