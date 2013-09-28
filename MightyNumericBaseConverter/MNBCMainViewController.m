//
//  MNBCMainViewController.m
//  MightyNumericBaseConverter
//
//  Created by Tugrul Savran on 9/28/13.
//  Copyright (c) 2013 CuriouScientists. All rights reserved.
//

#import "MNBCMainViewController.h"

@interface MNBCMainViewController ()

@end

@implementation MNBCMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(MNBCFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
