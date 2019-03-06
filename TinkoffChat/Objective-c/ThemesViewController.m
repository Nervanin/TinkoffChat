//
//  ThemesViewControler.m
//  TinkoffChat
//
//  Created by Konstantin on 03/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemesViewController.h"
#import "ThemesViewControllerDelegate.h"

@implementation ThemesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Themes";
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIColor* firstThemeColor = [UIColor lightGrayColor]; // release not needed
    UIColor* secondThemeColor = [UIColor darkGrayColor];
   // UIColor colorWithRed:1.0 green:(244.0/255.0) blue:(100.0/255.0) alpha:1.0]];
    UIColor* thirdThemeColor = [UIColor colorWithRed:1.0 green:(244.0/255.0) blue:(100.0/255.0) alpha:1.0];

    _model = [[Themes alloc]initFirstTheme:firstThemeColor secondTheme:secondThemeColor thirdTheme:thirdThemeColor];
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSData* colorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"themeColor"];
    if (colorData != nil) {
        UIColor* color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
        self.view.backgroundColor = color;
    }
}

- (void) dealloc {
    [_model release];
    
    [super dealloc];
}

- (Themes *)model {
    return _model;
}

- (void)setModel:(Themes *)model {
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
}

- (IBAction)cancellButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)chengeThemeButtonPressed:(UIButton *)sender {
    if (_delegate == nil)
        return;
    
    if([sender.currentTitle isEqualToString:@"Light theme"]) {
        [_delegate themesViewController:self didSelectTheme:self.model.lightColor];
    } else if ([sender.currentTitle isEqualToString:@"Blue theme"]) {
        [_delegate themesViewController:self didSelectTheme:self.model.blueColor];
    } else if ([sender.currentTitle isEqualToString:@"Dark theme"]) {
        [_delegate themesViewController:self didSelectTheme:self.model.blackColor];
    }
}

- (id<ThemesViewControllerDelegate>)delegate {
    return _delegate;
}

- (void)setDelegate:(id<ThemesViewControllerDelegate>)delegate {
    if (_delegate != delegate)
        _delegate = delegate;
}



@end




