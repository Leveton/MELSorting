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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetGame:) name:@"PrepPostNotificationResetGame" object:nil];
        
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
    NSLog(@"snapto");

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
                //NSLog(@"point%@ %@ subject%@", NSStringFromCGPoint(pointInSubjectsView), pointInSideDraggableObject ? @"inside" : @"outside", NSStringFromCGRect(dragSubject.frame));
                
                if (pointInSideDraggableObject)
                {
                    NSLog(@"started dragging an object");
                    self.dragContext = [[DragContext alloc] initWithDraggedView:dragSubject];
//                    draggableFrame = NSStringFromCGPoint(self.dragContext.draggedView.frame.origin);
                    draggableTag = dragSubject.tag;
                    [dragSubject removeFromSuperview];
                    [recognizer.view addSubview:dragSubject];
                    [self dragObjectAccordingToGesture:recognizer];
                    
                } else {
                    NSLog(@"started drag outside drag subjects");
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
                NSLog(@"ended drag event");
                CGPoint centerOfDraggedView = viewBeingDragged.center;
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
                        
                        NSString* draggableTagStr = [NSString stringWithFormat:@"%i", draggableTag];
                        NSString* droppableTagStr = [NSString stringWithFormat:@"%i", dropArea.tag];
                        NSDictionary *demoDict = [[NSDictionary alloc]initWithObjectsAndKeys:draggableTagStr, droppableTagStr, nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"PrepPostNotificationDemoFlash" object:nil userInfo:nil];
                        

                        NSString *string = [NSString stringWithFormat:@"%d", draggableTag];
                        NSString *string2 = [NSString stringWithFormat:@"%d", dropArea.tag];
                        
                        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:string, string2, nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"PrepPostNotificationEnfant0Animate" object:nil userInfo:userInfo];
                    }
                }
                
                if (!droppedViewInKnownArea)
                {
                    NSLog(@"release draggable object outside target views - snapping back to last known location");
                    [self.dragContext snapToOriginalPosition];
                }
                
                self.dragContext = nil;
                
            } else {
                NSLog(@"Nothing was being dragged");
            }
            break;
        }
    }
}
@end