#import "PanManager.h"

@interface PanManager ()

@property (nonatomic, strong) UIView *draggedView;
@property (nonatomic, strong) UIView *originalView;
@property (nonatomic, strong) NSArray *dragSubjects;
@property (nonatomic, strong) NSArray *dropAreas;
@property NSInteger draggingTag;
@property CGRect departureRect;
@property CGPoint originalPosition;

@end


@implementation PanManager

- (id)initWithDragSubjects:(NSArray *)dragSubjects andDropAreas:(NSArray *)dropAreas {
    self = [super init];
    
    if (self)
    {
        self.dropAreas = dropAreas;
        self.dragSubjects = dragSubjects;
    }
    
    return self;
}

- (void)snapToOriginalPosition
{
    [UIView animateWithDuration:0.3 animations:^()
     {
         CGPoint originalPointInSuperView = [self.draggedView.superview convertPoint:self.originalPosition fromView:self.originalView];
         self.draggedView.frame = CGRectMake(originalPointInSuperView.x, originalPointInSuperView.y, self.draggedView.frame.size.width, self.draggedView.frame.size.height);
     } completion:^(BOOL finished) {
         self.draggedView.frame = CGRectMake(self.originalPosition.x, self.originalPosition.y, self.draggedView.frame.size.width, self.draggedView.frame.size.height);
         
         [self.draggedView removeFromSuperview];
         [self.originalView addSubview:self.draggedView];
     }];
}

- (void)dragObjectAccordingToGesture:(UIPanGestureRecognizer *)recognizer
{
    CGPoint pointOnView = [recognizer locationInView:recognizer.view];
    self.draggedView.center = pointOnView;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            for (UIView *dragSubject in self.dragSubjects)
            {
                //todo: pointInside seems to answer no even if the point is actually inside the view?
                CGPoint pointInSubjectsView = [recognizer locationInView:dragSubject];
                BOOL pointInSideDraggableObject = [dragSubject pointInside:pointInSubjectsView withEvent:nil];
                
                if (pointInSideDraggableObject)
                {
                    
                    //self.dragContext = [[DragContext alloc] initWithDraggedView:dragSubject];
                    self.draggedView = dragSubject;
                    self.originalPosition = self.draggedView.frame.origin;
                    self.departureRect = self.draggedView.frame;
                    self.originalView = self.draggedView.superview;
                    self.draggingTag = dragSubject.tag;
                    [dragSubject removeFromSuperview];
                    [recognizer.view addSubview:dragSubject];
                    [self dragObjectAccordingToGesture:recognizer];
                    
                }
            }
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            [self dragObjectAccordingToGesture:recognizer];
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            
            UIView *viewBeingDragged = self.draggedView;
            BOOL droppedViewInKnownArea = NO;
            
            for (UIView *dropArea in self.dropAreas)
            {
                CGPoint pointInDropView = [recognizer locationInView:dropArea];
                
                if ([dropArea pointInside:pointInDropView withEvent:nil])
                {
                   droppedViewInKnownArea = YES;
                    
                    if ([self.delegate respondsToSelector:@selector(view:didAlternateWithView:fromOriginalRect:)])
                    {
                        [self.delegate view:viewBeingDragged didAlternateWithView:dropArea fromOriginalRect:self.departureRect];
                    }
                }
            }
            
            if (!droppedViewInKnownArea)
            {
                [self snapToOriginalPosition];
            }
            
            
            break;
        }
        case UIGestureRecognizerStatePossible:
        {
            
        }
        case UIGestureRecognizerStateCancelled:
        {
            
        }
        case UIGestureRecognizerStateFailed:
        {
            
        }
    }
}
@end