//
//  ViewController.m
//  GrowingTextViewHandler-objc
//
//  Created by hsusmita on 13/03/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import "ViewController.h"
#import "GrowingTextViewHandler.h"

@interface ViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (strong, nonatomic) GrowingTextViewHandler *handler;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.handler = [[GrowingTextViewHandler alloc]initWithTextView:self.textView
                                            withHeightConstraint:nil];
  [self.handler updateMinimumNumberOfLines:1 andMaximumNumberOfLine:INT_MAX];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
  [self.handler resizeTextViewWithAnimation:YES];
}

- (void)textViewDidChange:(UITextView *)textView {
  [self.handler resizeTextViewWithAnimation:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
  return YES;
}

- (IBAction)emptyText:(id)sender {
  [self.handler setText:nil withAnimation:YES];
}

- (IBAction)addText:(id)sender {
  [self.handler setText: @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
          withAnimation:YES];
}

@end
