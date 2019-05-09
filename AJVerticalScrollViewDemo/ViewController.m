//
//  ViewController.m
//  AJVerticalScrollViewDemo
//
//  Created by AJ_李坏 on 2019/5/7.
//  Copyright © 2019 LH. All rights reserved.
//

#import "ViewController.h"
#import "AJVerticalScrollView.h"

@interface ViewController ()

@property (nonatomic,strong)AJVerticalScrollView * verticalScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
#pragma mark dataSorce
    
    NSMutableArray *tempArr = @[].mutableCopy;
    NSMutableArray *imageArr = @[].mutableCopy;
    
    UILabel *labelOne = [UILabel new];
    labelOne.font = [UIFont systemFontOfSize:14];
    labelOne.text = @" 😭 这是第一个广告内容 😭 ";
    labelOne.textColor = [UIColor blackColor];
    
    UILabel *labelTwo = [UILabel new];
    labelTwo.font = [UIFont systemFontOfSize:14];
    labelTwo.text = @" 😂😂 这是第二个广告内容 😂😂 ";
    labelTwo.textColor = [UIColor blackColor];
    
    UILabel *labelThree = [UILabel new];
    labelThree.font = [UIFont systemFontOfSize:14];
    labelThree.text = @" 🤣🤣🤣 这是第三个广告内容 🤣🤣🤣 ";
    labelThree.textColor = [UIColor blackColor];
    
    [tempArr addObject:labelOne];
    [tempArr addObject:labelTwo];
    [tempArr addObject:labelThree];
    
    
    UIImageView * oneImage = [UIImageView new];
    [oneImage setImage:[UIImage imageNamed:@"kuaixun"]];
    [imageArr addObject:oneImage];
    
    UIImageView * twoImage = [UIImageView new];
    [twoImage setImage:[UIImage imageNamed:@"zuire"]];
    [imageArr addObject:twoImage];
    
    UIImageView * threeImage = [UIImageView new];
    [threeImage setImage:[UIImage imageNamed:@"zuire"]];
    [imageArr addObject:threeImage];
    
    self.verticalScrollView = [[AJVerticalScrollView alloc]initWithFrame:CGRectMake(10, 200, self.view.frame.size.width - 20,60) lableArray:tempArr imageArray:imageArr];
    self.verticalScrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.verticalScrollView];
    
    self.verticalScrollView.clickRow = ^(id  sender) {
        NSLog(@"click myself == %@",sender);
    };
    
    UIButton * stopBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 280, 100, 50)];
    [stopBtn setTitle:@"停止" forState:UIControlStateNormal];
    [stopBtn setTintColor:[UIColor whiteColor]];
    [stopBtn setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:stopBtn];
    [stopBtn addTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * startBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-150, 280, 100, 50)];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn setTintColor:[UIColor whiteColor]];
    [startBtn setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:startBtn];
    [startBtn addTarget:self action:@selector(startTimer) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)startTimer{
    [self.verticalScrollView startTimer];
}

-(void)stopTimer{
    [self.verticalScrollView stopTimer];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.verticalScrollView startTimer];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.verticalScrollView stopTimer];
}


@end
