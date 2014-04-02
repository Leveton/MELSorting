//
//  MELSViewController.m
//  MELSorting
//
//  Created by Mike Leveton on 8/4/13.
//  Copyright (c) 2013 mel. All rights reserved.
//

#import "MELSViewController.h"
#import "DragDropManager.h"
#import <QuartzCore/QuartzCore.h>

#define IS_PHONE_4 [[UIScreen mainScreen] bounds].size.height == 480
#define IS_PHONE_5 [[UIScreen mainScreen] bounds].size.height == 568
#define IPHONE_5_HEIGHT 94
#define IPHONE_4_HEIGHT 79.33
#define IPHONE_DIFF 14.67

@implementation MELSViewController
{
    UIView *viewA;
    UIView *viewB;
    UIView *viewC;
    UIView *viewD;
    UIView *viewE;
    UIView *viewF;
    UIView *draggableView0;
    UIView *draggableView1;
    UIView *draggableView2;
    UIView *draggableView3;
    UIView *draggableView4;
    UIView *draggableView5;
    NSArray *subViewArray;
    NSArray *superViewArray;
}

@synthesize dragDropManager;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDropManagerEvent:) name:@"MELPostNotificationdDemoAnimate" object:nil];
    
    viewA = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [viewA setBackgroundColor:[UIColor clearColor]];
    viewA.tag = 0;
    viewB = [[UIView alloc] initWithFrame:CGRectMake(10, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [viewB setBackgroundColor:[UIColor clearColor]];
    viewB.tag = 1;
    viewC = [[UIView alloc] initWithFrame:CGRectMake(10, IS_PHONE_4?IPHONE_4_HEIGHT*2:IPHONE_5_HEIGHT*2, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [viewC setBackgroundColor:[UIColor clearColor]];
    viewC.tag = 2;
    viewD = [[UIView alloc] initWithFrame:CGRectMake(10, IS_PHONE_4?IPHONE_4_HEIGHT*3:IPHONE_5_HEIGHT*3, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [viewD setBackgroundColor:[UIColor clearColor]];
    viewD.tag = 3;
    viewE = [[UIView alloc] initWithFrame:CGRectMake(10, IS_PHONE_4?IPHONE_4_HEIGHT*4:IPHONE_5_HEIGHT*4, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [viewE setBackgroundColor:[UIColor clearColor]];
    viewE.tag = 4;
    viewF = [[UIView alloc] initWithFrame:CGRectMake(10, IS_PHONE_4?IPHONE_4_HEIGHT*5:IPHONE_5_HEIGHT*5, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [viewF setBackgroundColor:[UIColor clearColor]];
    viewF.tag = 5;
    
    [[self view] addSubview:viewA];
    [[self view] addSubview:viewB];
    [[self view] addSubview:viewC];
    [[self view] addSubview:viewD];
    [[self view] addSubview:viewE];
    [[self view] addSubview:viewF];
    
    //add elements to drag and drop
    
    draggableView0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [draggableView0 setBackgroundColor:[UIColor colorWithRed:(77/255.f) green:(77/255.f) blue:(255/255.f) alpha:(255/255.f)]];
    draggableView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [draggableView1 setBackgroundColor:[UIColor colorWithRed:(26/255.f) green:(26/255.f) blue:(255/255.f) alpha:(255/255.f)]];
    draggableView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [draggableView2 setBackgroundColor:[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(230/255.f) alpha:(255/255.f)]];
    draggableView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [draggableView3 setBackgroundColor:[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(205/255.f) alpha:(255/255.f)]];
    draggableView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [draggableView4 setBackgroundColor:[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(179/255.f) alpha:(255/255.f)]];
    draggableView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [draggableView5 setBackgroundColor:[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(155/255.f) alpha:(255/255.f)]];
    
    draggableView0.tag = 0;
    draggableView1.tag = 1;
    draggableView2.tag = 2;
    draggableView3.tag = 3;
    draggableView4.tag = 4;
    draggableView5.tag = 5;
    
    [viewA addSubview:draggableView0];
    [viewB addSubview:draggableView1];
    [viewC addSubview:draggableView2];
    [viewD addSubview:draggableView3];
    [viewE addSubview:draggableView4];
    [viewF addSubview:draggableView5];
    
    
    NSMutableArray *draggableSubjects = [[NSMutableArray alloc] initWithObjects:draggableView0, draggableView1, draggableView2, draggableView3, draggableView4, draggableView5, nil];
    NSMutableArray *droppableAreas = [[NSMutableArray alloc] initWithObjects:viewA, viewB, viewC, viewD,viewE, viewF, nil];
    dragDropManager = [[DragDropManager alloc] initWithDragSubjects:draggableSubjects andDropAreas:droppableAreas];
    
    UIPanGestureRecognizer *uiTapGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:dragDropManager action:@selector(dragging:)];
    [[self view] addGestureRecognizer:uiTapGestureRecognizer];
    
    int draggableViewCount = [draggableSubjects count];
    
    for (int i = 0; i < draggableViewCount; i++){
        [self addLabels:[draggableSubjects objectAtIndex:i]];
    }
    
    subViewArray = [[NSArray alloc]initWithObjects:[[viewA subviews] objectAtIndex:0], [[viewB subviews] objectAtIndex:0], [[viewC subviews] objectAtIndex:0], [[viewD subviews] objectAtIndex:0], [[viewE subviews] objectAtIndex:0], [[viewF subviews] objectAtIndex:0], nil];
    
    superViewArray = [[NSArray alloc]initWithObjects:viewA,viewB,viewC,viewD,viewE,viewF, nil];
    
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma utilities

- (void)addLabels:(UIView *)draggable
{
    NSString *subLabelStr = [NSString stringWithFormat:@"%d", ([draggable tag] + 1)];
    UILabel *sublabelLeft = [[UILabel alloc]initWithFrame:CGRectMake(10, 33, 20, 20)];
    [sublabelLeft setText:subLabelStr];
    [sublabelLeft setFont:[UIFont fontWithName:@"Avenir-Medium" size:21.0]];
    [sublabelLeft setTextColor:[UIColor colorWithRed:(245/255.f) green:(245/255.f) blue:(245/255.f) alpha:(255/255.f)]];
    [sublabelLeft setBackgroundColor:[UIColor clearColor]];
    [draggable addSubview:sublabelLeft];
    
    UILabel *sublabelRight = [[UILabel alloc]initWithFrame:CGRectMake(280, 33, 20, 20)];
    [sublabelRight setText:subLabelStr];
    [sublabelRight setFont:[UIFont fontWithName:@"Avenir-Medium" size:21.0]];
    [sublabelRight setTextColor:[UIColor colorWithRed:(245/255.f) green:(245/255.f) blue:(245/255.f) alpha:(255/255.f)]];
    [sublabelRight setBackgroundColor:[UIColor clearColor]];
    [draggable addSubview:sublabelRight];
}

- (void)receiveDropManagerEvent:(NSNotification *)notification
{
    NSDictionary *pass = [notification userInfo];
    NSArray *dictKeys = [pass allKeys];
    NSArray *dictValues = [pass allValues];
    id dictValue = [dictValues objectAtIndex:0];
    NSInteger dictValueInt = [dictValue integerValue];
    id dictKey = [dictKeys objectAtIndex:0];
    NSInteger dictKeyInt = [dictKey integerValue];
    
    [UIView beginAnimations:@"tapTransition" context:nil];
    [UIView setAnimationDuration:0.6];
    
    [draggableView0 setFrame:CGRectMake(0, 0, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [draggableView1 setFrame:CGRectMake(0, 0, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [draggableView2 setFrame:CGRectMake(0, 0, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [draggableView3 setFrame:CGRectMake(0, 0, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [draggableView4 setFrame:CGRectMake(0, 0, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    [draggableView5 setFrame:CGRectMake(0, 0, 300, IS_PHONE_4?IPHONE_4_HEIGHT:IPHONE_5_HEIGHT)];
    
    [[superViewArray objectAtIndex:dictValueInt] addSubview:[subViewArray objectAtIndex:dictKeyInt]];
    [[superViewArray objectAtIndex:dictKeyInt] addSubview:[subViewArray objectAtIndex:dictValueInt]];
    
    [[subViewArray objectAtIndex:dictKeyInt] setTag:dictValueInt];
    [[subViewArray objectAtIndex:dictValueInt] setTag:dictKeyInt];
    
    subViewArray = [[NSArray alloc]initWithObjects:[[viewA subviews] objectAtIndex:0], [[viewB subviews] objectAtIndex:0], [[viewC subviews] objectAtIndex:0], [[viewD subviews] objectAtIndex:0], [[viewE subviews] objectAtIndex:0], [[viewF subviews] objectAtIndex:0], nil];
    [UIView commitAnimations];
    
}

@end