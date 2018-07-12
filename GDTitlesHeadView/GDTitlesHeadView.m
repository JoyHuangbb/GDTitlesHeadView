//
//  GDTitlesHeadView.m
//  CattleNet
//
//  Created by 黄彬彬 on 2018/3/29.
//  Copyright © 2018年 golden. All rights reserved.
//

#import "GDTitlesHeadView.h"

@interface GDTitlesHeadView()<UIScrollViewDelegate>
{
    UIScrollView * _scrollview;
    
    
    NSArray      * _titlesArray;
}

@property (nonatomic, strong) UIView       * bottomLine;
@property (nonatomic, strong) UIView       * mvRedLine;

@end

@implementation GDTitlesHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self layoutCustom];
    }
    
    return self;
}


- (void)layoutCustom
{
    self.backgroundColor = [UIColor whiteColor];
    //    self.backgroundColor = [UIColor colorWithRed:246/255.0f green:246/255.0f blue:246/255.0f alpha:1.0f];
    
    _scrollview = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.scrollEnabled = YES;
    _scrollview.delegate = self;
    _scrollview.scrollsToTop = NO;
    [self addSubview:_scrollview];
    
    _mvRedLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1.5, 0, 1.5)];
    _mvRedLine.backgroundColor = _highLightButtonTitleColor;
    _mvRedLine.layer.cornerRadius = 0.75;
    _mvRedLine.clipsToBounds = YES;
    [_scrollview addSubview:_mvRedLine];
    
    _buttonFont = [UIFont systemFontOfSize:15];
    _buttonTitleColor = [UIColor blackColor];
    
    _highLightButtonFont = [UIFont systemFontOfSize:17];
    _highLightButtonTitleColor = [UIColor blueColor];
    
    _ShowBottomLine = YES;
    _bottomLineColor = _highLightButtonTitleColor;
    
    _currentIndex = 0;
}


- (void)resetButtonsWithTitles:(NSArray<NSString *> *)titles
{
    [self addSubview:self.bottomLine];
    if (_ShowBottomLine == YES) {
        _bottomLine.hidden = NO;
    }else {
        _bottomLine.hidden = YES;
    }
    
    for (UIView *view in _scrollview.subviews) {
        [view  removeFromSuperview];
    }
    
    [_scrollview addSubview:_mvRedLine];
    _mvRedLine.backgroundColor = _highLightButtonTitleColor;
    
    if (!titles || titles.count == 0) return;
    _titlesArray = [NSArray arrayWithArray:titles];
    _currentIndex = 0;
    
    CGFloat iRight = 0;
    if (_titlesArray.count <= 4) {
        iRight = 0;
    }else {
        if (!_spacing_v && _spacing_v == 0) {
            iRight = 15;
        }
    }
    for (int i = 0; i < _titlesArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_titlesArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:_buttonTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:_highLightButtonTitleColor forState:UIControlStateSelected];
        btn.titleLabel.font = _buttonFont;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.tag = i + 200;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if (_titlesArray.count <= 4) {
            //低于五个的时候强制等分
            CGFloat iWidth = self.frame.size.width / _titlesArray.count;
            btn.frame = CGRectMake(iRight, 0, iWidth, self.frame.size.height - 0.5);
            _scrollview.scrollEnabled = NO;
        }else {
            
            CGSize size = [_titlesArray[i] boundingRectWithSize:CGSizeMake(self.frame.size.width - 30, self.frame.size.height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_highLightButtonFont} context:nil].size;
            
            if (_spacing_v && _spacing_v != 0) {
                btn.frame = CGRectMake(iRight + _spacing_v, 0, size.width, self.frame.size.height - 1.5);
                if (CGRectGetMaxX([btn frame]) + _spacing_v <= self.frame.size.width) {
                    _scrollview.scrollEnabled = NO;
                }else {
                    _scrollview.scrollEnabled = YES;
                }
            }else {
                btn.frame = CGRectMake(iRight, 0,  size.width + 30, self.frame.size.height - 1.5);//默认两个按钮之间最少距离
                if (CGRectGetMaxX([btn frame]) + 15 <= self.frame.size.width) {
                    _scrollview.scrollEnabled = NO;
                }else {
                    _scrollview.scrollEnabled = YES;
                }
            }
        }
        _scrollview.contentSize = CGSizeMake(CGRectGetMaxX([btn frame]) + 15, self.frame.size.height);
        iRight = CGRectGetMaxX([btn frame]);
        [_scrollview addSubview:btn];
        
        
        if (_titlesArray.count == 1) {
            _mvRedLine.hidden = YES;
        }else {
            _mvRedLine.hidden = NO;
        }
        if (i == 0) {
            CGSize size = [_titlesArray[i] boundingRectWithSize:CGSizeMake(self.frame.size.width - 30, self.frame.size.height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_highLightButtonFont} context:nil].size;
            //            _mvRedLine.frame.size.width = size.width;
            CGRect rect1 = _mvRedLine.frame;
            rect1.size.width = size.width;
            _mvRedLine.frame = rect1;
            if (_titlesArray.count <= 4) {
                CGFloat iWidth = self.frame.size.width / _titlesArray.count;
                if (iWidth < size.width) {
                    //                    _mvRedLine.width = iWidth;
                    
                    CGRect rect2 = _mvRedLine.frame;
                    rect2.size.width = iWidth;
                    _mvRedLine.frame = rect2;
                }
            }
            //            _mvRedLine.centerX = btn.centerX;
            [_mvRedLine setCenter:CGPointMake([btn center].x, _mvRedLine.center.y)];
        }
    }
}

- (void)setShowBottomLine:(BOOL)ShowBottomLine {
    _ShowBottomLine = ShowBottomLine;
    if (_ShowBottomLine == YES) {
        _bottomLine.hidden = NO;
    }else {
        _bottomLine.hidden = YES;
    }
}


- (void)selectButtonWithIndex:(NSInteger)index
{
    //  ????? 到底要不要回调代理   ？？？？？
    [self changeButtonStatus:index + 200];
}

- (void)btnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [self changeButtonStatus:btn.tag];
    [self.delegate GDTitlesHeadViewClicked:self index:btn.tag - 200];
}


- (void)changeButtonStatus:(NSInteger)index
{
    //原来的button
    UIButton *oldbtn = (UIButton *)[_scrollview viewWithTag:(200 + _currentIndex)];
    oldbtn.selected = NO;
    [oldbtn.titleLabel setFont:_buttonFont];
    
    //选中的button
    UIButton *activebtn = (UIButton *)[_scrollview viewWithTag:(index)];
    activebtn.selected = YES;
    [activebtn.titleLabel setFont:_highLightButtonFont];
    _currentIndex = index - 200;
    
    CGSize size = [_titlesArray[_currentIndex] boundingRectWithSize:CGSizeMake(self.frame.size.width - 30, self.frame.size.height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_highLightButtonFont} context:nil].size;
    
    CGFloat width = size.width;
    if (_titlesArray.count <= 4) {
        CGFloat iWidth = self.frame.size.width / _titlesArray.count;
        if (size.width < iWidth) {
            width = size.width;
        }else {
            width = iWidth;
        }
    }
    __typeof(self) weakself = self;
    [UIView animateWithDuration:0.2 animations:^{
        
        //        weakself.mvRedLine.width = width;
        CGRect rect1 = weakself.mvRedLine.frame;
        rect1.size.width = width;
        weakself.mvRedLine.frame = rect1;
        //        weakself.mvRedLine.centerX = activebtn.centerX;
        [weakself.mvRedLine setCenter:CGPointMake([activebtn center].x, weakself.mvRedLine.center.y)];
    }];
    
    if (_titlesArray.count <= 4) {
        return;
    }
    CGFloat offset = ((activebtn.frame.origin.x + (CGRectGetWidth([activebtn frame]) / 2.0)) - self.frame.size.width / 2.0);
    
    if (offset > 0) {//右端是否超出?
        if (_scrollview.contentSize.width <= self.frame.size.width) {
            return;
        }
        if (_scrollview.contentSize.width - (activebtn.frame.origin.x + (CGRectGetWidth([activebtn frame]) / 2.0)) >= self.frame.size.width / 2.0) {
            [_scrollview setContentOffset:CGPointMake(offset, 0) animated:YES];
        }else {
            [_scrollview setContentOffset:CGPointMake(_scrollview.contentSize.width - self.frame.size.width, 0) animated:YES];
        }
    }
    
    if (offset < 0) {
        if (_scrollview.contentSize.width <= self.frame.size.width) {
            return;
        }
        if ((activebtn.frame.origin.x + (CGRectGetWidth([activebtn frame]) / 2.0)) <= self.frame.size.width / 2.0) {
            [_scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
}

- (UIView *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5)];
        _bottomLine.backgroundColor = [UIColor blueColor];
        _bottomLine.hidden = YES;
    }
    return _bottomLine;
}

@end

