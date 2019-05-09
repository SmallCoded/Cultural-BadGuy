//
//  AJVerticalScrollView.m
//  AJVerticalScrollViewDemo
//
//  Created by AJ_李坏 on 2019/5/7.
//  Copyright © 2019 LH. All rights reserved.
//

#import "AJVerticalScrollView.h"

@interface AJVerticalScrollView()

//秒数
@property (nonatomic,assign)NSInteger seconds;
//背后的大view
@property (strong,nonatomic)UIView * backView;
//放label的view
@property (strong,nonatomic)UIView * lableView;
//放image的view
@property (strong,nonatomic)UIView * imageView;
//定时器
@property (strong,nonatomic)dispatch_source_t timer;
/* lable数组 */
@property (nonatomic,strong) NSMutableArray <UILabel *> *labelArray;
/* image数组 */
@property (nonatomic,strong) NSMutableArray <UIImageView *> *imageArray;

@end

@implementation AJVerticalScrollView

-(instancetype)initWithFrame:(CGRect)frame lableArray:(NSMutableArray *)labels imageArray:(nonnull NSMutableArray *)images
{
    if (self = [super initWithFrame:frame]) {
        
        self.labelArray = [NSMutableArray arrayWithCapacity:0];
        self.imageArray = [NSMutableArray arrayWithCapacity:0];
        
        self.labelArray = labels;
        self.imageArray = images;
        
        [self initLabels];
        [self initImages];
        
    }
    return self;
}

-(void)initImages{
    
    [self.imageArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.imageView addSubview:obj];
        obj.userInteractionEnabled = YES;
        
    }];
}

-(void)initLabels{
    
    [self.labelArray enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
        [self.lableView addSubview:obj];
        obj.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
        [obj addGestureRecognizer:tap];
        
    }];
    
}

-(void)labelClick:(UITapGestureRecognizer *)tap{
    
    if(self.clickRow){
        self.clickRow((UILabel *)tap.view);
    }
}

//定时器
-(void)startTimer
{
    __weak typeof(self)weakself = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 3 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self timerRepeatMethod];
            weakself.seconds++;
        });

    });
    dispatch_resume(_timer);
    
}

//定时器执行的方法
-(void)timerRepeatMethod{
    
    UILabel * createL = [self.labelArray objectAtIndex:_seconds % self.labelArray.count];
    UIImageView * createI = [self.imageArray objectAtIndex:_seconds % self.imageArray.count];
    
    if (_seconds <= self.labelArray.count) {
        
        //初始位置
        createL.frame = CGRectMake(0,self.lableView.frame.size.height, self.lableView.frame.size.width, self.lableView.frame.size.height);
    }
    
    if (_seconds <= self.imageArray.count) {
        
        createI.frame = CGRectMake(0,self.imageView.frame.size.height,self.imageView.frame.size.height, self.imageView.frame.size.height);
    }
    
    [UIView animateWithDuration:.65f animations:^{
        
        createL.frame = CGRectMake(0,0, self.lableView.frame.size.width, self.lableView.frame.size.height);
        createI.frame = CGRectMake(0,0,self.imageView.frame.size.height, self.imageView.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:.65f animations:^{
                
                createL.frame = CGRectMake(0, -self.lableView.frame.size.height, self.lableView.frame.size.width, self.lableView.frame.size.height);
                
                createI.frame = CGRectMake(0,-self.imageView.frame.size.height, self.imageView.frame.size.width, self.imageView.frame.size.height);
                
            } completion:^(BOOL finished) {
                
                createL.frame = CGRectMake(0,self.lableView.frame.size.height, self.lableView.frame.size.width, self.lableView.frame.size.height);
                
                createI.frame = CGRectMake(0,self.imageView.frame.size.height, self.imageView.frame.size.width, self.imageView.frame.size.height);
                
            }];
        });
    }];
}

-(void)stopTimer
{
    if(self.timer){
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
}

//lazy Data
-(UIView *)backView
{
    if (!_backView) {
        
        _backView = [[UIView alloc]initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor clearColor];
        _backView.userInteractionEnabled = YES;
        
        UIImageView * rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width - 15, 20, 20,20)];
        [rightImage setImage: [UIImage imageNamed:@"gengduo"]];
        [self.backView addSubview:rightImage];
        [self addSubview:self.backView];
        
    }
    return _backView;
}

-(UIView *)lableView
{
    if (!_lableView) {
        
        _lableView = [[UIView alloc]initWithFrame:CGRectMake(self.bounds.size.height + 10,10,self.bounds.size.width - self.bounds.size.height - 30,40)];
        _lableView.backgroundColor = [UIColor clearColor];
        _lableView.clipsToBounds = YES;
        _lableView.userInteractionEnabled = YES;
        [self.backView addSubview:_lableView];
    }
    return _lableView;
}

-(UIView *)imageView
{
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.bounds.size.height, self.bounds.size.height)];
        _imageView.clipsToBounds = YES;
        [self.backView addSubview:_imageView];
        
    }
    return _imageView;
}
@end
