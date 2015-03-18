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
  self.handler = [[GrowingTextViewHandler alloc]initWithTextView:self.textView withHeightConstraint:self.heightConstraint];
  [self.handler updateMinimumNumberOfLines:3 andMaximumNumberOfLine:8];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (void)textViewDidChange:(UITextView *)textView {
  [self.handler resizeTextViewWithAnimation:YES];
}
@end
