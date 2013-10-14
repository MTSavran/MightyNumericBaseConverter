//
//  MNBCMainViewController.m
//  Mighty Numeric Base Converter
//  Created by Mehmet Tugrul Savran and Batuhan Erdogan
//  Copyright (c) 2013 CuriouScientists. All rights reserved.



#import "MNBCMainViewController.h"

#import "stdio.h"
#import "stdlib.h"
#import "string.h"
#import "math.h"


@interface MNBCMainViewController ()
@end


@interface NSString (NSStringWithOctal)
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
        if((c<'0')||(c>'7')) {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"INPUT ERROR"
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


@implementation MNBCMainViewController


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return 0;
}


- (IBAction)convert:(id)sender{
    
    int number, love, b, batuhanic=0;
    static float sonuc=0;
    int minus = 0-1;
    
    switch (segmentedcontrol1.selectedSegmentIndex) {
            
        case 0:
        {
            NSString *numero = textField.text;
            int length = (int)[numero length];
            
            for (love=0; love<length; love++) {
                
                if ([numero characterAtIndex:love]!='1' && [numero characterAtIndex:love]!='0' && [numero characterAtIndex:love]!='.') {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"INPUT ERROR"
                                                                    message:@"Please use appropriate digits!"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"GOT IT!"
                                                          otherButtonTitles:nil];
                    [alert show];
                    
                    //sonuc = 0;
                    //numero = @"0";
                    
                    break;
                    
                }
            }
            
            for (love=0; love<length; love++) {
                if ([numero characterAtIndex:love]=='.') {
                    batuhanic = love + 1;
                    break;
                }
            }
            
            if (batuhanic > 1) {
                
                for (love=0; love<(batuhanic-1); love++) {
                    if ([numero characterAtIndex:love] == '1') {
                        sonuc = sonuc + pow(2.0, (double)(batuhanic-2-love));
                    } else {
                        continue;
                    }
                }
                
                for (love=batuhanic; love<length; love++) {
                    if ([numero characterAtIndex:love]=='1') {
                        sonuc = sonuc + pow(2.0, (double)(batuhanic-1-love));
                        
                    } else if ([numero characterAtIndex:love]=='.') {
                        batuhanic = 0;
                        
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
                
            } else if (batuhanic==1) {
                
                batuhanic = 0;
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"INPUT ERROR"
                                                                message:@"Please do not start with a period! If necessary, start with a 0, then place the period."
                                                               delegate:nil
                                                      cancelButtonTitle:@"GOT IT!"
                                                      otherButtonTitles:nil];
                [alert show];
                sonuc = 0;
                numero = @"0";
                
            } else {
                
                for (love=0; love<length; love++) {
                    if ([numero characterAtIndex:love]=='1') {
                        sonuc = sonuc + pow(2.0, (double)(length-1-love));
                    } else {
                        continue;
                    }
                }
            }
            
            switch (segmentedcontrol2.selectedSegmentIndex) {
                    
                case 0:
                    
                    label.text = [NSString stringWithFormat:@"%@", numero];
                    
                    break;
                    
                case 2:
                    
                    if (batuhanic>1) {
                        label.text = [NSString stringWithFormat:@"%.3f", sonuc];
                    } else {
                        label.text = [NSString stringWithFormat:@"%d", (int)sonuc];
                    }
                    
                    break;
                    
                case 1:
                    
                    label.text = [NSString stringWithFormat:@"%o", (int)sonuc];
                    
                    break;
                    
                case 3:
                    
                    label.text = [NSString stringWithFormat:@"%x", (int)sonuc];
                    
                    break;
                    
                default:
                    break;
            }
            
            break;
        }
        case 2: //DEC'DEN......
            
            sonuc = [textField.text floatValue];
            
            float floater;
            number = (int)sonuc;
            floater = sonuc - number;
            
            
            switch (segmentedcontrol2.selectedSegmentIndex) {
                    
                case 0: //BIN'E......
                    
                {
                    
                   //if(sonuc > 999999999) { number = 0; } /////////ben seyettim bunu
                   
                    if (sonuc!=0) {
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
                        
                        if (floater > 0) {
                            
                            output[a+1] = '.';
                            int tugrul = 0;
                            
                            for (tugrul=minus; floater>0; tugrul--) {
                                if (floater < pow(2, tugrul)) {
                                    output[a+1-tugrul] = '0';
                                } else {
                                    output[a+1-tugrul] = '1';
                                    floater -= pow(2, tugrul);
                                }
                            }
                            
                            output[a+1-tugrul] = '\0';
                        }
                        
                        label.text = [NSString stringWithFormat:@"%s", output];
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
            
            
            
            /*if ([hex characterAtIndex:hexAsInt]!='1' && [hex characterAtIndex:hexAsInt]!='0' && [hex characterAtIndex:hexAsInt]!= '2' && [hex characterAtIndex:hexAsInt]!='3' && [hex characterAtIndex:hexAsInt]!= '4' && [hex characterAtIndex:hexAsInt]!='5' && [hex characterAtIndex:hexAsInt]!='6' && [hex characterAtIndex:hexAsInt]!='7' && [hex characterAtIndex:hexAsInt]!='8' && [hex characterAtIndex:hexAsInt]!='9' && [hex characterAtIndex:hexAsInt]!='a' && [hex characterAtIndex:hexAsInt]!='b' && [hex characterAtIndex:hexAsInt]!='c' && [hex characterAtIndex:hexAsInt]!='d' && [hex characterAtIndex:hexAsInt]!='e' && [hex characterAtIndex:hexAsInt]!='f')
            
                {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"INPUT ERROR"
                                                                                                                                                                                                                                                                                                                                                                                                                                      message:@"Please use appropriate digits!"
                                                                                                                                                                                                                                                                                                                                                                                                                                     delegate:nil
                                                                                                                                                                                                                                                                                                                                                                                                                            cancelButtonTitle:@"GOT IT!"
                                                                                                                                                                                                                                                                                                                                                                                                                            otherButtonTitles:nil];
                [alert show];}
                
             */
            
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
    
    number=0; love=0; b=0; batuhanic=0; sonuc=0;
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

