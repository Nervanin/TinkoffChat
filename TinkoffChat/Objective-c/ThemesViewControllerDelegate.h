//
//  ThemesViewControllerDelegate.h
//  TinkoffChat
//
//  Created by Konstantin on 05/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

@class ThemesViewController;

@protocol ThemesViewControllerDelegate <NSObject>

- (void)themesViewController:(ThemesViewController *)controller didSelectTheme:(UIColor *)selectedTheme;

@end

