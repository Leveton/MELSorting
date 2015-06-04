//
//  MELSortingView.h
//  MELSorting
//
//  Created by Mike Leveton on 4/1/15.
//  Copyright (c) 2015 mel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MELSortingViewDelegate;

@interface MELSortingView : UIView

@property (weak, nonatomic) id<MELSortingViewDelegate> delegate;

+ (instancetype)sortingViewWithViews:(NSInteger)views XOffset:(CGFloat)XOffset YOffset:(CGFloat)YOffset andWidth:(CGFloat)width;
- (id)initWithViews:(NSInteger)views XOffset:(CGFloat)XOffset YOffset:(CGFloat)YOffset andWidth:(CGFloat)width;
- (void)addLabels;

@end


@protocol MELSortingViewDelegate <NSObject>

@optional

- (void)view:(MELSortingView *)sortingView wasMovedWithView:(UIView *)aView;
- (void)view:(MELSortingView *)sortingView didAlternateView:(UIView *)departureView withView:(UIView *)destinationView;

@end
