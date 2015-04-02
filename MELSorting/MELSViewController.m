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
    
    MELSortingView *sortView = [[MELSortingView alloc]initWithFrame:self.view.frame andNumberOfViews:6];
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

@end