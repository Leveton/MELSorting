//
//  MELSortingView.m
//  MELSorting
//
//  Created by Mike Leveton on 4/1/15.
//  Copyright (c) 2015 mel. All rights reserved.
//

#import "MELSortingView.h"
#import "PanManager.h"

@interface MELSortingView ()<PanManagerDelegate>

@property (nonatomic, strong) PanManager *panManager;
@property (nonatomic, strong) NSMutableArray *dragSubjects;
@property (nonatomic, strong) NSMutableArray *dropAreas;
@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation MELSortingView

- (instancetype)initWithFrame:(CGRect)frame andNumberOfViews:(NSInteger)views
{
    NSAssert(views > 2 && views < 8, NSLocalizedString(@"You must have at least 2 and at most 6 views", nil));
    NSAssert(frame.size.width >= 100, NSLocalizedString(@"View width must be at least 100", nil));
    NSAssert(frame.size.height >= 177.5, NSLocalizedString(@"View height must be at least 177.5", nil));
    
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.dragSubjects = [NSMutableArray array];
        self.dropAreas = [NSMutableArray array];
        self.dictionary = [NSMutableDictionary dictionary];
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height/views;
        
        for (NSInteger i = 0; i < views; i++)
        {
            UIView *dragView = [[UIView alloc]initWithFrame:CGRectMake(0, i*height, width, height)];
            dragView.tag = i;
            dragView.userInteractionEnabled = YES;
            [dragView setBackgroundColor:[UIColor colorWithRed:(77-(i*10))/255.f green:(77-(i*10))/255.f blue:(255-(i*20))/255.f alpha:255/255.f]];
            [self addSubview:dragView];
            [self.dragSubjects addObject:dragView];
            
            UIView *dropView = [[UIView alloc]initWithFrame:CGRectMake(0, i*height, width, height)];
            dropView.tag = i;
            dropView.userInteractionEnabled = NO;
            [self addSubview:dropView];
            [self.dropAreas addObject:dropView];
            
            [self.dictionary setObject:dragView forKey:[NSNumber numberWithInteger:dropView.tag]];
            
            self.panManager = [[PanManager alloc] initWithDragSubjects:self.dragSubjects andDropAreas:self.dropAreas];
            self.panManager.delegate = self;
            
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.panManager action:@selector(handlePan:)];
            [self addGestureRecognizer:pan];
            
        }
    }
    
    return self;
}

- (void)addLabels
{
    for (UIView *dragView in self.dragSubjects)
    {
        CGFloat width = self.frame.size.width;
        CGFloat fontSize = width/16;
        CGFloat height = dragView.frame.size.height;
        CGFloat labelDimension = height*.25;
        //NSLog(@"labeldim: %f", labelDimension);
        CGFloat padding = width*.03125;
        
        NSString *subLabelStr = [NSString stringWithFormat:@"%ld", ([dragView tag] + 1)];
        UILabel *sublabelLeft = [[UILabel alloc]initWithFrame:CGRectMake(padding, (height - labelDimension)/2, labelDimension, labelDimension)];
        [sublabelLeft setText:subLabelStr];
        [sublabelLeft setTextAlignment:NSTextAlignmentCenter];
        [sublabelLeft setFont:[UIFont fontWithName:@"Avenir-Medium" size:fontSize]];
        sublabelLeft.adjustsFontSizeToFitWidth = YES;
        [sublabelLeft setMinimumScaleFactor:0.05];
        [sublabelLeft setTextColor:[UIColor whiteColor]];
        [dragView addSubview:sublabelLeft];
        
        UILabel *sublabelRight = [[UILabel alloc]initWithFrame:CGRectMake(width - (labelDimension+padding), (height - labelDimension)/2, labelDimension, labelDimension)];
        [sublabelRight setText:subLabelStr];
        [sublabelRight setTextAlignment:NSTextAlignmentCenter];
        [sublabelRight setFont:[UIFont fontWithName:@"Avenir-Medium" size:fontSize]];
        sublabelRight.adjustsFontSizeToFitWidth = YES;
        [sublabelRight setMinimumScaleFactor:0.05];
        [sublabelRight setTextColor:[UIColor whiteColor]];
        [dragView addSubview:sublabelRight];
    }
}

#pragma mark - panManagerDelegate

- (void)viewWasMovedWithView:(UIView *)view
{
    if ([self.delegate respondsToSelector:@selector(view:wasMovedWithView:)])
    {
        [self.delegate view:self wasMovedWithView:view];
    }
}


- (void)view:(UIView *)view didAlternateWithView:(UIView *)destinationView fromOriginalRect:(CGRect)originalRect
{
    NSInteger draggedViewTag = view.tag;
    
    UIView *viewReplaced = [self.dictionary objectForKey:[NSNumber numberWithInteger:destinationView.tag]];
    
    [view setFrame:destinationView.frame];
    [viewReplaced setFrame:originalRect];
    
    [self.dictionary setObject:view forKey:[NSNumber numberWithInteger:destinationView.tag]];
    [self.dictionary setObject:viewReplaced forKey:[NSNumber numberWithInteger:draggedViewTag]];
    
    view.tag = destinationView.tag;
    viewReplaced.tag = draggedViewTag;
    
    if ([self.delegate respondsToSelector:@selector(view:didAlternateView:withView:)])
    {
        [self.delegate view:self didAlternateView:viewReplaced withView:destinationView];
    }
}

@end
