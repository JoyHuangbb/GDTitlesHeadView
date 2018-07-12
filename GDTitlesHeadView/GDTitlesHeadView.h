//
//  GDTitlesHeadView.h
//  CattleNet
//
//  Created by 黄彬彬 on 2018/3/29.
//  Copyright © 2018年 golden. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GDTitlesHeadView;

@protocol GDTitlesHeadViewDelegate

@optional
- (void)GDTitlesHeadViewClicked:(GDTitlesHeadView *)view index:(NSInteger)index;

@end

@interface GDTitlesHeadView : UIView

@property (nonatomic, strong) UIFont  * buttonFont;//正常情况下按钮字体大小
@property (nonatomic, strong) UIColor * buttonTitleColor;//正常情况下按钮字体颜色

@property (nonatomic, strong) UIFont  * highLightButtonFont;//高亮情况下按钮字体大小 默认是与正常情况下一样大
@property (nonatomic, strong) UIColor * highLightButtonTitleColor;//高亮情况下按钮字体颜色， 默认是与下划线一样的颜色

@property (nonatomic, assign) CGFloat   spacing_v;//两个按钮之间的距离，如果没有特殊要求不用设置

@property (nonatomic, assign) BOOL      ShowBottomLine;//是否展示下划线
@property (nonatomic, strong) UIColor * bottomLineColor;//下划线颜色，默认主色调

@property (nonatomic, assign) NSInteger currentIndex;//当前选择

@property (nonatomic, weak) id<GDTitlesHeadViewDelegate> delegate;/* 代理 */

- (void)selectButtonWithIndex:(NSInteger)index;//对某个按钮进行选择，上一个选择的会自动返还
- (void)resetButtonsWithTitles:(NSArray<NSString *> *)titles;//传入数据源

@end
