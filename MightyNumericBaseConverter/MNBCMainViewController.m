//
//  MNBCMainViewController.m
//  Mighty Numeric Base Converter
//  Created by Mehmet Tugrul Savran and Batuhan Erdogan
//  Copyright (c) 2013 CuriouScientists. All rights reserved.
//LET THE GAMES BEGIN! 



#import "MNBCMainViewController.h"

#import "stdio.h"
#import "stdlib.h"
#import "string.h"
#import "math.h"


@interface MNBCMainViewController ()
@end


@interface NSString (NSStringWithOctal)   //Putting the octal input as a string into interface.
-(int)octalIntValue;
@end


@implementation NSString (NSStringWithOctal)
-(int)octalIntValue
{
    int iResult = 0, iBase = 1;
    char c;
    
    for(int i=(int)[self length]-1; i>=0; i--)
    {
        c = [self characterAtIndex:i];
        if((c<'0')||(c>'7')) //If user doesn't use an input inside the appropriate interval for octal base, app pops out an error window.
        {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"INPUT ERROR"
                                                                                      message:@"Please use appropriate digits!"
                                                                                     delegate:nil
                                                                            cancelButtonTitle:@"GOT IT!"
                                                                            otherButtonTitles:nil];
            [alert show]; return 0;}
        
        iResult += (c - '0') * iBase;
        iBase *= 8;
    }
    return iResult;
}
@end


@implementation MNBCMainViewController //Everything begins <<<HERE>>>


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder]; //To get rid of the keyboard when user taps "return"
    return 0;
}


- (IBAction)convert:(id)sender{ //This is the "Convert!" button.
    
    int number, love, b, batuhanic=0; //defining variables.
    static float sonuc=0;
    int minus = 0-1;
    
    switch (segmentedcontrol1.selectedSegmentIndex) { //This is the code referring to the bar on top, with base options (binary, octal, decimal, hexadec)
            
        case 0: //If user is converting from binary....
        {
            NSString *numero = textField.text; //App receives this binary input as a string.
            int length = (int)[numero length]; //Taking the length of this string.
            
            for (love=0; love<length; love++) { //As you know, this app can work with non-integer inputs, and this is a geniune counter to determine the linear location of period. Why? To prevent computational errors.
                
                if ([numero characterAtIndex:love]!='1' && [numero characterAtIndex:love]!='0' && [numero characterAtIndex:love]!='.') { //OK here, we say if the input has a character other than 1, 0 or a "." (period), the program pops out an error window.
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"INPUT ERROR"
                                                                   message:@"Please use appropriate digits!"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"GOT IT!"
                                                          otherButtonTitles:nil];
                                                                    [alert show];
                                                                           break;
                    
                }
            }
            
            for (love=0; love<length; love++) {
                if ([numero characterAtIndex:love]=='.') {
                    batuhanic = love + 1;//Assigning the linear coordinate of period.
                    break;
                }
            }
            
            if (batuhanic > 1) { //if everything is going well...
                
                for (love=0; love<(batuhanic-1); love++) {
                    if ([numero characterAtIndex:love] == '1') {
                        sonuc = sonuc + pow(2.0, (double)(batuhanic-2-love)); // We are scanning the array elements until the coordinate of the period. If we find "1", we take the relevant powers of 2 and save it to the variable "sonuc", which means results in Turkish.
                    } else {
                        continue;
                    }
                }
                
                for (love=batuhanic; love<length; love++) {

                    if ([numero characterAtIndex:love]=='1') { //Now, we are processing the digits after the period with the same method.
                        sonuc = sonuc + pow(2.0, (double)(batuhanic-1-love));
                        
                    } else if ([numero characterAtIndex:love]=='.') {
                        batuhanic = 0; //If the user puts two periods..
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"INPUT ERROR"
                                                                        message:@"Please do not use two periods!"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"GOT IT!"
                                                              otherButtonTitles:nil];
                        [alert show];
                        sonuc = 0;
                        numero = @"0";
                    }
                    else {
                        continue;
                    }
                }
                
            } else if (batuhanic==1) { //If user starts with a period... App pops out an error window.
                
                batuhanic = 0;
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"INPUT ERROR"
                                                                message:@"Please do not start with a period! If necessary, start with a 0, then place the period."
                                                               delegate:nil
                                                      cancelButtonTitle:@"GOT IT!"
                                                      otherButtonTitles:nil];
                [alert show];
                sonuc = 0;
                numero = @"0";
                
            } else { //If user uses an integer, then yay! Everything is much simpler...
                
                for (love=0; love<length; love++) {
                    if ([numero characterAtIndex:love]=='1') {
                        sonuc = sonuc + pow(2.0, (double)(length-1-love));
                    } else {
                        continue;
                    }
                }
            }
            // So far we have scanned the binary string and found its value. Now, let's convert it!

            switch (segmentedcontrol2.selectedSegmentIndex) { //This is the code referring to the bar at the bottom with base options (binary, octal, decimal, hexadec).
                    
                case 0: //If user wants to convert from binary to binary, program outputs the input.
                    
                    label.text = [NSString stringWithFormat:@"%@", numero];
                    
                    break;
                    
                case 2: //If user wants to convert from binary to octal...
                    
                    if (batuhanic>1) {
                        label.text = [NSString stringWithFormat:@"%.3f", sonuc];
                    } else {
                        label.text = [NSString stringWithFormat:@"%d", (int)sonuc];
                    }
                    
                    break;
                    
                case 1: //If user wants to convert from binary to decimal.
                    
                    label.text = [NSString stringWithFormat:@"%o", (int)sonuc];
                    
                    break;
                    
                case 3: //If user wants to convert from binary to hexadecimal...
                    
                    label.text = [NSString stringWithFormat:@"%x", (int)sonuc];
                    
                    break;
                    
                default:
                    break;
            }
            
            break;
        }
        case 2: //If user wants to convert FROM BINARY
            
            sonuc = [textField.text floatValue]; //App scans the number
            
            float floater;
            number = (int)sonuc; //the integer fragment of the number
            floater = sonuc - number;//the non-integer fragment of the number
            
            
            switch (segmentedcontrol2.selectedSegmentIndex) {
                    
                case 0: //If user wants to convert from decimal to binary
                    
                {
                   
                   
                    if (sonuc!=0) {
                        static int a;
                        
                        a = log2(number); //App takes the logarythm of the number on base 2, in order to find the maximum number of digits.
                        
                        
                        int i, y, x;
                        
                        char output[1024]; // The output string and its size.

                        
                        
                        output[a+1] = '\0';
                        
                        for(i=a; i>=0; i--)
                        { // Now, to calculate the number's value in binary, we are continuously dividing the number into 2.
                            x = number/pow(2, i);
                            if (x < 1) {
                                output[a-i] = '0'; //If number is larger than 2 to the power of i, we assign "0" to that respective digit.
                            } else {
                                output[a-i] = '1'; // Otherwise, we assign 1 to that respective digit. And we go on until the remainder is 0. How do we find the remainder? BELOW!
                                y = pow(2, i);
                                number %= y; //Find the remainder!
                            }
                        }
                        
                        if (floater > 0) { //If the user input a non-integer value, we do something similar.

                            
                            output[a+1] = '.';
                            int tugrul = 0;
                            
                            for (tugrul=minus; floater>0; tugrul--) { //minus equals minus 1 (-1). It will divide the number by 2 to the power -1 initially.
                                if (floater < pow(2, tugrul)) {
                                    output[a+1-tugrul] = '0';
                                } else {
                                    output[a+1-tugrul] = '1';
                                    floater -= pow(2, tugrul);
                                }
                            }
                            
                            output[a+1-tugrul] = '\0';
                        }
                        
                        label.text = [NSString stringWithFormat:@"%s", output]; //Victory! Program now writes the result. The remaining has the same logic.
                    } else {
                        label.text = [NSString stringWithFormat:@"%d", 0];
                    }
                    
                    break;
                }
                case 2:
                {
                    if (floater > 0) {
                        
                        label.text = [NSString stringWithFormat:@"%.3f", sonuc];
                        
                    } else {
                        
                        label.text = [NSString stringWithFormat:@"%d", number];
                    }
                    
                    break;
                }
                case 1:
                {
                    label.text = [NSString stringWithFormat:@"%o", number];
                    break;
                }
                case 3:
                {
                    label.text = [NSString stringWithFormat:@"%x", number];
                    break;
                }
                default:
                    break;
            }
            
            break;
            
        case 1:
            
            number = [textField.text octalIntValue];
            
            switch (segmentedcontrol2.selectedSegmentIndex) {
                case 0:
                {
                    if (number!=0) {
                        static int a;
                        
                        a = log2(number);
                        
                        int i, y, x;
                        
                        char output[1024];
                        
                        output[a+1] = '\0';
                        
                        for(i=a; i>=0; i--)
                        {
                            x = number/pow(2, i);
                            if (x < 1) {
                                output[a-i] = '0';
                            } else {
                                output[a-i] = '1';
                                y = pow(2, i);
                                number %= y;
                            }
                        }
                        label.text = [NSString stringWithFormat:@"%s", output];
                    } else {
                        label.text = [NSString stringWithFormat:@"%d", 0];
                    }
                    
                    break;
                }
                case 2:
                {
                    label.text = [NSString stringWithFormat:@"%d", number];
                    
                    break;
                }
                case 1:
                {
                    label.text = [NSString stringWithFormat:@"%o", number];
                    
                    break;
                }
                case 3:
                {
                    label.text = [NSString stringWithFormat:@"%x", number];
                    
                    break;
                }
                default:
                    break;
            }
            
            break;
            
        case 3:
        {
            NSString *hex = textField.text;
            NSUInteger hexAsInt;
            [[NSScanner scannerWithString:hex] scanHexInt:&hexAsInt];
            if ([hex length] == 0) {
               hexAsInt = 0;
            }
            switch (segmentedcontrol2.selectedSegmentIndex) {
                case 0:
                {
                    if (hexAsInt!=0) {
                        static int a;
                        
                        a = log2(hexAsInt);
                        
                        int i, y, x;
                        
                        char output[1024];
                        
                        output[a+1] = '\0';
                        
                        for(i=a; i>=0; i--)
                        {
                            x = hexAsInt/pow(2, i);
                            if (x < 1) {
                                output[a-i] = '0';
                            } else {
                                output[a-i] = '1';
                                y = pow(2, i);
                                hexAsInt %= y;
                            }
                        }
                        label.text = [NSString stringWithFormat:@"%s", output];
                    } else {
                        label.text = [NSString stringWithFormat:@"%d", 0];
                    }
                    
                    break;
                }
                case 2:
                {
                    label.text = [NSString stringWithFormat:@"%d", (int)hexAsInt];
                    break;
                }
                case 1:
                {
                    label.text = [NSString stringWithFormat:@"%o", (int)hexAsInt];
                    break;
                }
                case 3:
                {
                    label.text = [NSString stringWithFormat:@"%lx", (unsigned long)hexAsInt];
                    break;
                }
                default:
                {
                    break;
                }
            }
            
            break;
        }
            
        default:
            break;
    }
    
    number=0; love=0; b=0; batuhanic=0; sonuc=0; //Finally, app clears all the variables.
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

