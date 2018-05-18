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
@property (nonatomic, strong) NSMutableArray<UIView *> *dragSubjects;
@property (nonatomic, strong) NSMutableArray<UIView *> *dropAreas;
@property (nonatomic, strong) NSMutableDictionary<NSNumber*, UIView*> *dictionary;
@end

@implementation MELSortingView

+ (instancetype)sortingViewWithFrame:(CGRect)frame forView:(UIView *)superView numberOfViews:(NSInteger)numberOfViews{
    return [[self alloc] initWithFrame:frame forView:superView numberOfViews:numberOfViews];
}

- (id)initWithFrame:(CGRect)frame forView:(UIView *)superView numberOfViews:(NSInteger)numberOfViews{
    NSAssert(superView.bounds.size.width >= frame.size.width && superView.bounds.size.height >= frame.size.height, NSLocalizedString(@"view is too big", nil));
    NSAssert((superView.bounds.size.width * 0.333f) < frame.size.width, NSLocalizedString(@"view is too narrow", nil));
    NSAssert((superView.bounds.size.height * 0.333f) < frame.size.height, NSLocalizedString(@"view is too short", nil));
    
    self = [super initWithFrame:frame];
    
    if (self){
        self.dragSubjects = [NSMutableArray array];
        self.dropAreas = [NSMutableArray array];
        self.dictionary = [NSMutableDictionary dictionary];
        
        CGFloat height = self.frame.size.height/numberOfViews;
        
        for (NSInteger i = 0; i < numberOfViews; i++){
            UIView *dragView = [[UIView alloc]initWithFrame:CGRectMake(0, height*i, frame.size.width, height)];
            dragView.tag = i;
            dragView.userInteractionEnabled = YES;
            [dragView setBackgroundColor:[UIColor colorWithRed:(77-(i*10))/255.f green:(77-(i*10))/255.f blue:(255-(i*20))/255.f alpha:255/255.f]];
            [self addSubview:dragView];
            [self.dragSubjects addObject:dragView];
            
            UIView *dropView = [[UIView alloc]initWithFrame:dragView.frame];
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

- (void)setLabels:(NSArray<NSString *> *)labels{
    _labels = labels;
    [self.dragSubjects enumerateObjectsUsingBlock:^(UIView *dragView, NSUInteger idx, BOOL *stop) {
        CGFloat width = self.frame.size.width;
        CGFloat fontSize = width/16;
        CGFloat height = dragView.frame.size.height;
        CGFloat labelDimension = height*.25;
        CGFloat padding = width*.03;
        NSString *subLabelStr = (idx < self.labels.count) ? [self.labels objectAtIndex:idx] : @"";
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
    }];
}


#pragma mark - panManagerDelegate

- (void)viewWasMovedWithView:(UIView *)view{
    if ([self.delegate respondsToSelector:@selector(view:wasMovedWithView:)]){
        [self.delegate view:self wasMovedWithView:view];
    }
}

- (void)view:(UIView *)view didAlternateWithView:(UIView *)destinationView fromOriginalRect:(CGRect)originalRect{
    NSInteger draggedViewTag = view.tag;
    
    UIView *viewReplaced = [self.dictionary objectForKey:[NSNumber numberWithInteger:destinationView.tag]];
    
    [view setFrame:destinationView.frame];
    [viewReplaced setFrame:originalRect];
    
    [self.dictionary setObject:view forKey:[NSNumber numberWithInteger:destinationView.tag]];
    [self.dictionary setObject:viewReplaced forKey:[NSNumber numberWithInteger:draggedViewTag]];
    
    view.tag = destinationView.tag;
    viewReplaced.tag = draggedViewTag;
    
    if ([self.delegate respondsToSelector:@selector(view:didAlternateView:withView:)]){
        [self.delegate view:self didAlternateView:viewReplaced withView:destinationView];
    }
}

@end
