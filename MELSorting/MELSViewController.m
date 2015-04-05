//
//  MELSViewController.m
//  MELSorting
//
//  Created by Mike Leveton on 8/4/13.
//  Copyright (c) 2015 mel. All rights reserved.
//

#import "MELSViewController.h"
#import "MELSortingView.h"

@interface MELSViewController ()<MELSortingViewDelegate>

@end

@implementation MELSViewController

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
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MELSortingView *sortView = [[MELSortingView alloc]initWithViews:6 withXOffset:0 andYOffset:0 andWidth:self.view.frame.size.width];
    sortView.delegate = self;
    [sortView addLabels];
    [self.view addSubview:sortView];

}


-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


#pragma mark - MELSortingViewDelegate

- (void)view:(MELSortingView *)sortingView wasMovedWithView:(UIView *)aView
{
    NSLog(@"a view at position %ld was moved", aView.tag);
}

- (void)view:(MELSortingView *)sortingView didAlternateView:(UIView *)departureView withView:(UIView *)destinationView
{
    NSLog(@"a view at position %ld was swapped with a view at position %ld", (long)departureView.tag, (long)destinationView.tag);
}

@end