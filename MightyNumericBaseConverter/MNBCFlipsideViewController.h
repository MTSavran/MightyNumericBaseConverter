//
//  MNBCFlipsideViewController.h
//  MightyNumericBaseConverter
//
//  Created by Tugrul Savran on 9/28/13.
//  Copyright (c) 2013 CuriouScientists. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MNBCFlipsideViewController;

@protocol MNBCFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(MNBCFlipsideViewController *)controller;
@end

@interface MNBCFlipsideViewController : UIViewController

@property (weak, nonatomic) id <MNBCFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
