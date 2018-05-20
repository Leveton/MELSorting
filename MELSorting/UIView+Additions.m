//
//  UIView+Additions.m
//  MELSorting
//
//  Created by Michael Leveton on 5/18/18.
//  Copyright © 2018 mel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Additions.h"

@implementation UIView (Additions)

- (CGPoint)centeredOriginForChildFrame:(CGRect)frame{
    CGRect bounds = [self bounds];
    CGFloat minX = CGRectGetMidX(bounds) - (CGRectGetWidth(frame)/2);
    return CGPointMake(minX, (CGRectGetHeight(bounds)/2) - (CGRectGetHeight(frame)/2));
}

@end
