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
    NSDictionary *dict0;
    NSDictionary *dict1;
    NSDictionary *dict2;
    NSDictionary *dict3;
    NSDictionary *dict4;
    NSDictionary *dict5;
    NSDictionary *dict6;
    NSDictionary *dict7;
    NSDictionary *dict8;
    NSDictionary *dict9;
    NSDictionary *dict10;
    NSDictionary *dict11;
    NSDictionary *dict12;
    NSDictionary *dict13;
    NSDictionary *dict14;
    NSDictionary *dict15;
    NSDictionary *dict16;
    NSDictionary *dict17;
    NSDictionary *dict18;
    NSDictionary *dict19;
    NSDictionary *dict20;
    NSDictionary *dict21;
    NSDictionary *dict22;
    NSDictionary *dict23;
    NSDictionary *dict24;
    NSDictionary *dict25;
    NSDictionary *dict26;
    NSDictionary *dict27;
    NSDictionary *dict28;
    NSDictionary *dict29;
    NSDictionary *dict30;
    NSDictionary *dict31;
    NSDictionary *dict32;
    NSDictionary *dict33;
    NSDictionary *dict34;
    NSDictionary *dict35;
    NSDictionary *dict36;
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDropManagerEvent:) name:@"MELPostNotificationdDemoAnimate" object:nil];
    
    viewA = [[UIView alloc] initWithFrame:CGRectMake(10, 16, 300, 86)];
    [viewA setBackgroundColor:[UIColor clearColor]];
    viewA.tag = 0;
    viewB = [[UIView alloc] initWithFrame:CGRectMake(10, 102, 300, 86)];
    [viewB setBackgroundColor:[UIColor clearColor]];
    viewB.tag = 1;
    viewC = [[UIView alloc] initWithFrame:CGRectMake(10, 188, 300, 86)];
    [viewC setBackgroundColor:[UIColor clearColor]];
    viewC.tag = 2;
    viewD = [[UIView alloc] initWithFrame:CGRectMake(10, 274, 300, 86)];
    [viewD setBackgroundColor:[UIColor clearColor]];
    viewD.tag = 3;
    viewE = [[UIView alloc] initWithFrame:CGRectMake(10, 360, 300, 86)];
    [viewE setBackgroundColor:[UIColor clearColor]];
    viewE.tag = 4;
    viewF = [[UIView alloc] initWithFrame:CGRectMake(10, 446, 300, 86)];
    [viewF setBackgroundColor:[UIColor clearColor]];
    viewF.tag = 5;
    
    [[self view] addSubview:viewA];
    [[self view] addSubview:viewB];
    [[self view] addSubview:viewC];
    [[self view] addSubview:viewD];
    [[self view] addSubview:viewE];
    [[self view] addSubview:viewF];
    
    //add elements to drag and drop
    
    draggableView0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 86)];
    [draggableView0 setBackgroundColor:[UIColor colorWithRed:(77/255.f) green:(77/255.f) blue:(255/255.f) alpha:(255/255.f)]];
    draggableView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 86)];
    [draggableView1 setBackgroundColor:[UIColor colorWithRed:(26/255.f) green:(26/255.f) blue:(255/255.f) alpha:(255/255.f)]];
    draggableView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 86)];
    [draggableView2 setBackgroundColor:[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(230/255.f) alpha:(255/255.f)]];
    draggableView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 86)];
    [draggableView3 setBackgroundColor:[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(205/255.f) alpha:(255/255.f)]];
    draggableView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 86)];
    [draggableView4 setBackgroundColor:[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(179/255.f) alpha:(255/255.f)]];
    draggableView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 86)];
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
    
    dict0 = [[NSDictionary alloc]initWithObjectsAndKeys:@"0", @"0", nil];
    dict1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"0", @"1", nil];
    dict2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"0", @"2", nil];
    dict3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"0", @"3", nil];
    dict4 = [[NSDictionary alloc]initWithObjectsAndKeys:@"0", @"4", nil];
    dict5 = [[NSDictionary alloc]initWithObjectsAndKeys:@"0", @"5", nil];
    dict6 = [[NSDictionary alloc]initWithObjectsAndKeys:@"1", @"0", nil];
    dict7 = [[NSDictionary alloc]initWithObjectsAndKeys:@"1", @"1", nil];
    dict8 = [[NSDictionary alloc]initWithObjectsAndKeys:@"1", @"2", nil];
    dict9 = [[NSDictionary alloc]initWithObjectsAndKeys:@"1", @"3", nil];
    dict10 = [[NSDictionary alloc]initWithObjectsAndKeys:@"1", @"4", nil];
    dict11 = [[NSDictionary alloc]initWithObjectsAndKeys:@"1", @"5", nil];
    dict12 = [[NSDictionary alloc]initWithObjectsAndKeys:@"2", @"0", nil];
    dict13 = [[NSDictionary alloc]initWithObjectsAndKeys:@"2", @"1", nil];
    dict14 = [[NSDictionary alloc]initWithObjectsAndKeys:@"2", @"2", nil];
    dict15 = [[NSDictionary alloc]initWithObjectsAndKeys:@"2", @"3", nil];
    dict16 = [[NSDictionary alloc]initWithObjectsAndKeys:@"2", @"4", nil];
    dict17 = [[NSDictionary alloc]initWithObjectsAndKeys:@"2", @"5", nil];
    dict18 = [[NSDictionary alloc]initWithObjectsAndKeys:@"3", @"0", nil];
    dict19 = [[NSDictionary alloc]initWithObjectsAndKeys:@"3", @"1", nil];
    dict20 = [[NSDictionary alloc]initWithObjectsAndKeys:@"3", @"2", nil];
    dict21 = [[NSDictionary alloc]initWithObjectsAndKeys:@"3", @"3", nil];
    dict22 = [[NSDictionary alloc]initWithObjectsAndKeys:@"3", @"4", nil];
    dict23 = [[NSDictionary alloc]initWithObjectsAndKeys:@"3", @"5", nil];
    dict24 = [[NSDictionary alloc]initWithObjectsAndKeys:@"4", @"0", nil];
    dict25 = [[NSDictionary alloc]initWithObjectsAndKeys:@"4", @"1", nil];
    dict26 = [[NSDictionary alloc]initWithObjectsAndKeys:@"4", @"2", nil];
    dict27 = [[NSDictionary alloc]initWithObjectsAndKeys:@"4", @"3", nil];
    dict28 = [[NSDictionary alloc]initWithObjectsAndKeys:@"4", @"4", nil];
    dict29 = [[NSDictionary alloc]initWithObjectsAndKeys:@"4", @"5", nil];
    dict30 = [[NSDictionary alloc]initWithObjectsAndKeys:@"5", @"0", nil];
    dict31 = [[NSDictionary alloc]initWithObjectsAndKeys:@"5", @"1", nil];
    dict32 = [[NSDictionary alloc]initWithObjectsAndKeys:@"5", @"2", nil];
    dict33 = [[NSDictionary alloc]initWithObjectsAndKeys:@"5", @"3", nil];
    dict34 = [[NSDictionary alloc]initWithObjectsAndKeys:@"5", @"4", nil];
    dict35 = [[NSDictionary alloc]initWithObjectsAndKeys:@"5", @"5", nil];
    
    subViewArray = [[NSArray alloc]initWithObjects:[[viewA subviews] objectAtIndex:0], [[viewB subviews] objectAtIndex:0], [[viewC subviews] objectAtIndex:0], [[viewD subviews] objectAtIndex:0], [[viewE subviews] objectAtIndex:0], [[viewF subviews] objectAtIndex:0], nil];
    
    superViewArray = [[NSArray alloc]initWithObjects:viewA,viewB,viewC,viewD,viewE,viewF, nil];
    
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
    
    [draggableView0 setFrame:CGRectMake(0, 0, 300, 86)];
    [draggableView1 setFrame:CGRectMake(0, 0, 300, 86)];
    [draggableView2 setFrame:CGRectMake(0, 0, 300, 86)];
    [draggableView3 setFrame:CGRectMake(0, 0, 300, 86)];
    [draggableView4 setFrame:CGRectMake(0, 0, 300, 86)];
    [draggableView5 setFrame:CGRectMake(0, 0, 300, 86)];
    
    [[superViewArray objectAtIndex:dictValueInt] addSubview:[subViewArray objectAtIndex:dictKeyInt]];
    [[superViewArray objectAtIndex:dictKeyInt] addSubview:[subViewArray objectAtIndex:dictValueInt]];
    
    [[subViewArray objectAtIndex:dictKeyInt] setTag:dictValueInt];
    [[subViewArray objectAtIndex:dictValueInt] setTag:dictKeyInt];
    
    subViewArray = [[NSArray alloc]initWithObjects:[[viewA subviews] objectAtIndex:0], [[viewB subviews] objectAtIndex:0], [[viewC subviews] objectAtIndex:0], [[viewD subviews] objectAtIndex:0], [[viewE subviews] objectAtIndex:0], [[viewF subviews] objectAtIndex:0], nil];
    [UIView commitAnimations];
    
}

@end