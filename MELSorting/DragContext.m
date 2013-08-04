#import "DragContext.h"


@implementation DragContext {
    
    UIView *_draggedView;
    CGPoint _originalPosition;
    UIView *_originalView;
}
@synthesize draggedView = _draggedView;
@synthesize originalView = _originalView;

- (id)initWithDraggedView:(UIView *)draggedView {
    self = [super init];
    if (self)
    {
        _draggedView = draggedView;
        _originalPosition = _draggedView.frame.origin;
        _originalView = _draggedView.superview;
    }
    
    return self;
}

- (void)snapToOriginalPosition {
    [UIView animateWithDuration:0.3 animations:^() {
        CGPoint originalPointInSuperView = [_draggedView.superview convertPoint:_originalPosition fromView:_originalView];
        _draggedView.frame = CGRectMake(originalPointInSuperView.x, originalPointInSuperView.y, _draggedView.frame.size.width, _draggedView.frame.size.height);
    } completion:^(BOOL finished) {
        _draggedView.frame = CGRectMake(_originalPosition.x, _originalPosition.y, _draggedView.frame.size.width, _draggedView.frame.size.height);
        [_draggedView removeFromSuperview];
        [_originalView addSubview:_draggedView];
    }];
}

@end