//
//  AJVerticalScrollView.h
//  AJVerticalScrollViewDemo
//
//  Created by AJ_李坏 on 2019/5/7.
//  Copyright © 2019 LH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJVerticalScrollView : UIView


/* label的点击事件 */
@property (nonatomic,strong) void (^clickRow)(id sender);


/**
 构造函数
 
 @param frame view frame
 @param labels  in view the labels
 @return self
 */
-(instancetype)initWithFrame:(CGRect)frame lableArray:(NSMutableArray *)labels imageArray:(NSMutableArray *)images;

/**
 开启定时器
 */
-(void)startTimer;

/**
 结束定时器
 */
-(void)stopTimer;


@end

NS_ASSUME_NONNULL_END
