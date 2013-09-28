//
//  MNBCFlipsideViewController.m
//  MightyNumericBaseConverter
//
//  Created by Tugrul Savran on 9/28/13.
//  Copyright (c) 2013 CuriouScientists. All rights reserved.
//

#import "MNBCFlipsideViewController.h"

@interface MNBCFlipsideViewController ()

@end

@implementation MNBCFlipsideViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

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

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
