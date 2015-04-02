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

- (instancetype)initWithFrame:(CGRect)frame andNumberOfViews:(NSInteger)views;
- (void)addLabels;

@end


@protocol MELSortingViewDelegate <NSObject>

@optional

- (void)userDidMoveView:(MELSortingView *)view;
- (void)view:(MELSortingView *)view didAlternateWithView:(MELSortingView *)destinationView;

@end
