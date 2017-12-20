//
//  WWCalVuew.m
//  WWCalView
//
//  Created by 王威 on 2017/12/18.
//  Copyright © 2017年 WWin. All rights reserved.
//

#import "WWCalVuew.h"
@interface WWCalVuew()
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)double aaa;

@end
@implementation WWCalVuew
-(void)awakeFromNib{
    [super awakeFromNib];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [[[NSBundle mainBundle]loadNibNamed:@"WWCalVuew" owner:self options:nil]lastObject];
        [self addSubview:self.bgView];
    }
    return self;
}
- (IBAction)tag:(UILongPressGestureRecognizer *)sender {
    [self.dataArray removeAllObjects];
    self.aaa = 0.00;
     [self change];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [[[NSBundle mainBundle]loadNibNamed:@"WWCalVuew" owner:self options:nil] lastObject];
        [self addSubview:self.bgView];
    }
    return self;
}
-(void)layoutSubviews{
    self.bgView.frame = self.bounds;
}
- (IBAction)click:(UIButton *)sender {
    NSInteger conut = self.dataArray.count;
    if (conut == 0) {
        conut = 0;
        if (sender.tag == 15) {
            return;
        }else{
            [self.dataArray addObject:@""];
        }
    }else{
        conut = self.dataArray.count - 1;
    }
     NSString *str = self.dataArray[conut];
    if (([str isEqualToString:@"+"] || [str isEqualToString:@"-"] || [str isEqualToString:@"*"] || [str isEqualToString:@"/"]) && sender.tag != 15) {
        if (sender.tag == 10) {
          [self.dataArray addObject:@"0."];
        }else if(sender.tag < 10){
         [self.dataArray addObject:[NSString stringWithFormat:@"%ld",sender.tag]];
        }
    }else{
        if (sender.tag < 11) {
            if (sender.tag == 10) {//点击的是.
                if ([str isEqualToString:@""]==YES) {
                    str = [NSString stringWithFormat:@"0.%@",str];
                    [self.dataArray replaceObjectAtIndex:conut withObject:str];
                }else if([str containsString:@"."]){
                    
                }else{
                    str = [NSString stringWithFormat:@"%@.",str];
                    [self.dataArray replaceObjectAtIndex:conut withObject:str];
                }
            }else{//点击的是0...9
                if (sender.tag == 0) {
                    if ([str isEqualToString:@"0"]) {
                        str = [NSString stringWithFormat:@"%@.%ld",str,sender.tag];
                        [self.dataArray replaceObjectAtIndex:conut withObject:str];
                    }else{
                        str = [NSString stringWithFormat:@"%@0",str];
                        [self.dataArray replaceObjectAtIndex:conut withObject:str];
                    }
                }else{
                    str = [NSString stringWithFormat:@"%@%ld",str,(long)sender.tag];
                    [self.dataArray replaceObjectAtIndex:conut withObject:str];
                }
            }
        }else if (sender.tag >= 11 && sender.tag <= 14){
            if (self.dataArray.count == 0) {
                
            }else if ([str isEqualToString:@""] == YES){
                
            }else{
                if([str isEqualToString:@"0."] == YES){
                    str = @"0";
                    [self.dataArray replaceObjectAtIndex:conut withObject:str];
                }
                switch (sender.tag) {
                    case 11:{
                        [self.dataArray addObject:@"+"];
                    }
                        break;
                    case 12:{
                        [self.dataArray addObject:@"-"];
                    }
                        break;
                    case 13:{
                        [self.dataArray addObject:@"*"];
                    }
                        break;
                    case 14:{
                        [self.dataArray addObject:@"/"];
                    }
                        break;
                    default:
                        break;
                }
            }
        }else{
            if ([str containsString:@"+"] == NO || [str containsString:@"-"] == NO || [str containsString:@"*"] == NO || [str containsString:@"/"] == NO) {
                NSLog(@"%@",str);
                if (str.length == 1) {
                    [self.dataArray removeObjectAtIndex:conut];
                }else if (str.length == 0){
                    
                }else{
                    str = [str substringWithRange:NSMakeRange(0, str.length - 1)];
                    [self.dataArray replaceObjectAtIndex:conut withObject:str];
                }
            }else if (self.dataArray.count == 0){
                
            }else{
                [self.dataArray removeObjectAtIndex:conut];
            }
        }
    }
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dattArray = [[NSMutableArray alloc]initWithArray:self.dataArray];
//    for (int idx = 0; idx<self.dataArray.count; idx++) {
//        if ([self.dataArray[idx] isEqualToString:@"*"] || [self.dataArray[idx] isEqualToString:@"/"]) {
//            double str ;
//            if (idx != self.dataArray.count - 1) {
//                if ([self.dataArray[idx] isEqualToString:@"*"]) {
//                    str = [self.dataArray[idx - 1] doubleValue]* [self.dataArray[idx + 1] doubleValue];
//                }else{
//                    str = [self.dataArray[idx - 1] doubleValue] / [dattArray[idx + 1] doubleValue];
//                }
////                [dattArray addObject:<#(nonnull id)#>]
//            }
//        }
//    }
    NSMutableArray *thisArray = [NSMutableArray new];
    [dattArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"*"] || [obj isEqualToString:@"/"]) {
            double str ;
            if (idx != dattArray.count - 1) {
                if ([obj isEqualToString:@"*"]) {
                    str = [thisArray[thisArray.count - 1] doubleValue] * [dattArray[idx + 1] doubleValue];
                }else{
                    str = [thisArray[thisArray.count - 1] doubleValue] / [dattArray[idx + 1] doubleValue];
                }
                [thisArray removeObjectAtIndex:thisArray.count -1];
                [thisArray addObject:[NSString stringWithFormat:@"%f",str]];
            }
        }else{
            if (thisArray.count ==0) {
              [thisArray addObject:obj];
            }else if ([self isPureFloat:thisArray[thisArray.count -1]] || [self isPureInt:thisArray[thisArray.count -1]]){
                if ([self isPureFloat:obj] || [self isPureInt:obj]) {
                    
                }else{
                    [thisArray addObject:obj];
                }
            }else{
                [thisArray addObject:obj];
            }
        }
    }];
    [thisArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            weakSelf.aaa = [obj doubleValue];
        }else{
            if (idx % 2 == 0) {
                if ([[thisArray objectAtIndex: idx - 1] isEqualToString:@"+"]) {
                    weakSelf.aaa += [obj doubleValue];
                }else{
                    weakSelf.aaa -= [obj doubleValue];
                }
            }
        }
    }];
    [self change];
}
//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}
// 是否为整形
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
-(void)change{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"love" object:nil userInfo:@{@"question":[self.dataArray componentsJoinedByString:@""],@"answer":self.dataArray.count == 0 ? @"0.00" : [NSString stringWithFormat:@"%.2f",self.aaa]}];
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]initWithObjects:@"", nil];
    }
    return _dataArray;
}
@end
