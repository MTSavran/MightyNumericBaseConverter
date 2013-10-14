//
//  MNBCMainViewController.h
//  MightyNumericBaseConverter
//
//  Created by Tugrul Savran on 9/28/13.
//  Copyright (c) 2013 CuriouScientists. All rights reserved.
//

#import "MNBCFlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface MNBCMainViewController : UIViewController <UITextFieldDelegate>

{
    
    IBOutlet UITextField *textField;
    IBOutlet UILabel *label;
    IBOutlet UISegmentedControl *segmentedcontrol1;
    IBOutlet UISegmentedControl *segmentedcontrol2;
}


- (IBAction)convert:(id)sender;





@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
