//
//  ANFirstScreenViewController.m
//  CrystalsAndDragonsTest
//
//  Created by Admin on 10.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ANFirstScreenViewController.h"
#import "ANLabirintManager.h"
#import "ANLabyrinth.h"

@interface ANFirstScreenViewController ()<UITextFieldDelegate>

@end

@implementation ANFirstScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.okButton.enabled = NO;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"stoneWall2.png"]]];
}

- (IBAction)okAction:(id)sender {
    NSInteger width = [self.widthTextField.text integerValue];
    NSInteger hight = [self.hightTextField.text integerValue];
        [ [ANLabirintManager getLabirintManager] createLabyrinthWithWidth:width
                                                                 andHight:hight];
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if([textField isEqual:self.widthTextField]){
        [self.hightTextField becomeFirstResponder];
    }
    else {
        NSInteger width = [self.widthTextField.text integerValue];
        NSInteger hight = [self.hightTextField.text integerValue];
        if(width<2 && hight<2){
            self.warningLabel.text = @"Вы ввели неверные данные\n Попробуйте снова";
            self.warningLabel.textColor = [UIColor redColor];
            self.widthTextField.text = nil;
            self.hightTextField.text = nil;
            [self.widthTextField becomeFirstResponder];
        }
        else {
            [textField resignFirstResponder];
            self.okButton.enabled = YES;
            self.warningLabel.text = nil;
        }
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *replaceString =[textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger result = [replaceString integerValue];
    NSCharacterSet *set = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray * resultArray =[replaceString componentsSeparatedByCharactersInSet:set];
    return result<101 && [resultArray count]<=1;
}

@end
