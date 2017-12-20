//
//  ViewController.m
//  WWTextFiled
//
//  Created by 王威 on 2017/12/20.
//  Copyright © 2017年 WWin. All rights reserved.
//

#import "ViewController.h"
#import "WWTextFiled.h"
@interface ViewController ()<delegate>{
    UIButton *_btn;
}
@property(nonatomic,strong)WWTextFiled *textFiled;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 300, 40)];
    [_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btn setTitle:@"" forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(chage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    [self.view addSubview:self.textFiled];
}
-(void)chage:(UIButton *)sender{
    self.textFiled.text = sender.titleLabel.text;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textFiled registerFirstResponsder];
}
-(WWTextFiled *)textFiled{
    if (!_textFiled) {
        _textFiled = [[WWTextFiled alloc]initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width -20, 30)];
        _textFiled.delegate = self;
    }
    return _textFiled;
}
-(void)ansWer:(NSString *)str{
    [_btn setTitle:str forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
