#import "DragDropManager.h"
#import "DragContext.h"

@implementation DragDropManager
{
    
    NSArray *_dragSubjects;
    NSArray *_dropAreas;
    DragContext *_dragContext;
    int draggableTag;
    NSMutableArray *russianDollArray;
}

@synthesize dragContext = _dragContext;
@synthesize dropAreas = _dropAreas;


- (id)initWithDragSubjects:(NSArray *)dragSubjects andDropAreas:(NSArray *)dropAreas {
    self = [super init];
    if (self)
    {
        _dropAreas = dropAreas;
        _dragSubjects = dragSubjects;
        _dragContext = nil;
        russianDollArray = [[NSMutableArray alloc]init];
    }
    
    return self;
}

- (void)dragObjectAccordingToGesture:(UIPanGestureRecognizer *)recognizer {
    if (self.dragContext)
    {
        CGPoint pointOnView = [recognizer locationInView:recognizer.view];
        self.dragContext.draggedView.center = pointOnView;
    }
}

- (void)resetGame:(id)sender
{

}

- (void)dragging:(id)sender {
    UIPanGestureRecognizer *recognizer = (UIPanGestureRecognizer *) sender;
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            for (UIView *dragSubject in _dragSubjects) {
                //todo: pointInside seems to answer no even if the point is actually inside the view?
                CGPoint pointInSubjectsView = [recognizer locationInView:dragSubject];
                BOOL pointInSideDraggableObject = [dragSubject pointInside:pointInSubjectsView withEvent:nil];
                
                if (pointInSideDraggableObject)
                {
                    
                    self.dragContext = [[DragContext alloc] initWithDraggedView:dragSubject];
//                    draggableFrame = NSStringFromCGPoint(self.dragContext.draggedView.frame.origin);
                    draggableTag = dragSubject.tag;
                    [dragSubject removeFromSuperview];
                    [recognizer.view addSubview:dragSubject];
                    [self dragObjectAccordingToGesture:recognizer];
                    
                } else {
                   
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
            
            if (self.dragContext)
            {
                UIView *viewBeingDragged = self.dragContext.draggedView;
                //draggableFrame = NSStringFromCGPoint(viewBeingDragged.frame.origin);
                //draggableFrame = viewBeingDragged.frame.origin;
                BOOL droppedViewInKnownArea = NO;
                //   for(int i = 0; i < [self.dropAreas count]; i++) {
                //     UIView *dropArea = [self.dropAreas objectAtIndex:i];
                
                for (UIView *dropArea in self.dropAreas) {
                    CGPoint pointInDropView = [recognizer locationInView:dropArea];
                    //NSLog(@"tag %i pointInDropView %@ center of dragged view %@", dropArea.tag, NSStringFromCGPoint(pointInDropView), NSStringFromCGPoint(centerOfDraggedView));
                    
                    if ([dropArea pointInside:pointInDropView withEvent:nil])
                    {
                        droppedViewInKnownArea = YES;
                        //NSLog(@"dropped subject %@ on to view tag %i", NSStringFromCGRect(viewBeingDragged.frame), dropArea.tag);
                        [viewBeingDragged removeFromSuperview];
                        [dropArea addSubview:viewBeingDragged];
                        //change origin to match offset on new super view
                        viewBeingDragged.frame = CGRectMake(pointInDropView.x - (viewBeingDragged.frame.size.width / 2), pointInDropView.y - (viewBeingDragged.frame.size.height / 2), viewBeingDragged.frame.size.width, viewBeingDragged.frame.size.height);

                        NSString *draggable = [NSString stringWithFormat:@"%d", draggableTag];
                        NSString *droppable = [NSString stringWithFormat:@"%d", dropArea.tag];
                        
                        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:draggable, droppable, nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"MELPostNotificationdDemoAnimate" object:nil userInfo:userInfo];
                    }
                }
                
                if (!droppedViewInKnownArea)
                {
                    [self.dragContext snapToOriginalPosition];
                }
                
                self.dragContext = nil;
                
            } else {
                
            }
            break;
        }
    }
}
@end