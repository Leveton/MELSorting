//
//  MELSortingView.m
//  MELSorting
//
//  Created by Mike Leveton on 4/1/15.
//  Copyright (c) 2015 mel. All rights reserved.
//

#import "MELSortingView.h"
#import "PanManager.h"
#import "UIView+Additions.h"

@interface MELSortingView ()<PanManagerDelegate>
@property (nonatomic, strong) PanManager *panManager;
@property (nonatomic, strong) NSMutableArray<UIView *> *dragSubjects;
@property (nonatomic, strong) NSMutableArray<UIView *> *dropAreas;
@property (nonatomic, strong) NSMutableDictionary<NSNumber*, UIView*> *dictionary;
@property (nonatomic, strong) UIView *canvasView;
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
            [[self canvasView] addSubview:dragView];
            [self.dragSubjects addObject:dragView];
            
            UIView *dropView = [[UIView alloc]initWithFrame:dragView.frame];
            dropView.tag = i;
            dropView.userInteractionEnabled = NO;
            [[self canvasView] addSubview:dropView];
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

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect canvasFrame = [[self canvasView] bounds];
    canvasFrame.size = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    [[self canvasView] setFrame:canvasFrame];
}

#pragma mark - views

- (UIView *)canvasView{
    if (!_canvasView){
        _canvasView = [UIView new];
        [self addSubview:_canvasView];
    }
    return _canvasView;
}

#pragma mark - setters

- (void)setLabels:(NSArray<NSString *> *)labels{
    _labels = labels;
    [self.dragSubjects enumerateObjectsUsingBlock:^(UIView *dragView, NSUInteger idx, BOOL *stop) {
        CGFloat fontSize = self.frame.size.width/16;
        NSString *string = (idx < self.labels.count) ? [self.labels objectAtIndex:idx] : @"";
        UILabel *label = [UILabel new];
        [label setText:string];
        
        [label sizeToFit];
        
        CGRect frame = [label frame];
        frame.origin = CGPointMake([dragView centeredOriginForChildFrame:frame].x, [dragView centeredOriginForChildFrame:frame].y);
        [label setFrame:frame];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont fontWithName:@"Avenir-Medium" size:fontSize]];
        [label setTextColor:[UIColor whiteColor]];
        [dragView addSubview:label];
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
