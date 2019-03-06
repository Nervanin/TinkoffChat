//
//  ThemesViewController.h
//  TinkoffChat
//
//  Created by Konstantin on 04/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

#ifndef ThemesViewController_h
#define ThemesViewController_h


#import <UIKit/UIKit.h>
#import "ThemesViewControllerDelegate.h"
#import "Themes.h"

@class Themes;
@protocol  ThemesViewControllerDelegate;

@interface ThemesViewController : UIViewController {
    id<ThemesViewControllerDelegate> _delegate;
    Themes *_model;
}
//@property (retain, nonatomic) IBOutlet UIButton *lightTheme;
//@property (retain, nonatomic) IBOutlet UIButton *blueTheme;
//@property (retain, nonatomic) IBOutlet UIButton *darkTheme;

- (void)dealloc;

@property (assign, nonatomic) id<ThemesViewControllerDelegate> delegate;
@property (retain, nonatomic) Themes *model;

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)chengeThemeButtonPressed:(id)sender;

@end

#endif /* ThemesViewController_h */

