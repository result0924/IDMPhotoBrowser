//
//  IDMPhotoBrowser.h
//  IDMPhotoBrowser
//
//  Created by Michael Waterfall on 14/10/2010.
//  Copyright 2010 d3i. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import "IDMPhoto.h"
#import "IDMPhotoProtocol.h"
#import "IDMCaptionView.h"

// Delgate
@class IDMPhotoBrowser;
@protocol IDMPhotoBrowserDelegate <NSObject>
@optional
- (void)willAppearPhotoBrowser:(IDMPhotoBrowser *)photoBrowser;
- (void)willDisappearPhotoBrowser:(IDMPhotoBrowser *)photoBrowser;
- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didShowPhotoAtIndex:(NSUInteger)index;
- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDismissAtPageIndex:(NSUInteger)index;
- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser willDismissAtPageIndex:(NSUInteger)index;
- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDismissActionSheetWithButtonIndex:(NSUInteger)buttonIndex photoIndex:(NSUInteger)photoIndex;
- (IDMCaptionView *)photoBrowser:(IDMPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index;
- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didTapDeleteButtonAtIndex:(NSUInteger)index;
- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didTapReportButtonAtIndex:(NSUInteger)index;

@end

@interface reportObject : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;

@end

// IDMPhotoBrowser
@interface IDMPhotoBrowser : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate>

// Properties
@property (nonatomic, strong) id <IDMPhotoBrowserDelegate> delegate;

// Toolbar customization
@property (nonatomic) BOOL displayToolbar;
@property (nonatomic) BOOL displayCounterLabel;
@property (nonatomic) BOOL displayArrowButton;
@property (nonatomic) BOOL displayActionButton;
@property (nonatomic) BOOL displayDeleteButton;
@property (nonatomic, strong) NSArray *actionButtonTitles;
@property (nonatomic, weak) UIImage *leftArrowImage, *leftArrowSelectedImage;
@property (nonatomic, weak) UIImage *rightArrowImage, *rightArrowSelectedImage;
@property (nonatomic, weak) UIImage *deleteButtonImage;

// Report button customization
// Should set displayReportButton to YES & displayToolbar to NO to display report button
@property (nonatomic) BOOL displayReportButton;
@property (nonatomic, copy) NSString *reportButtonTitle;
@property (nonatomic, strong) UIColor *reportButtonTextColor;
@property (nonatomic, strong) NSArray<reportObject *> *reportTitleAry;

// View customization
@property (nonatomic) BOOL displayDoneButton;
@property (nonatomic) BOOL useWhiteBackgroundColor;
@property (nonatomic, weak) UIImage *doneButtonImage;
@property (nonatomic, weak) UIColor *trackTintColor, *progressTintColor;

@property (nonatomic, weak) UIImage *scaleImage;

@property (nonatomic) BOOL arrowButtonsChangePhotosAnimated;

@property (nonatomic) BOOL forceHideStatusBar;
@property (nonatomic) BOOL usePopAnimation;
@property (nonatomic) BOOL disableVerticalSwipe;

// Default value: true. Set to false to tell the photo viewer not to hide the interface when scrolling
@property (nonatomic) BOOL autoHideInterface;

// Defines zooming of the background (default 1.0)
@property (nonatomic) float backgroundScaleFactor;

// Animation time (default .28)
@property (nonatomic) float animationDuration;

// Init
- (id)initWithPhotos:(NSArray *)photosArray;

// Init (animated)
- (id)initWithPhotos:(NSArray *)photosArray animatedFromView:(UIView*)view;

// Init with NSURL objects
- (id)initWithPhotoURLs:(NSArray *)photoURLsArray;

// Init with NSURL objects (animated)
- (id)initWithPhotoURLs:(NSArray *)photoURLsArray animatedFromView:(UIView*)view;

// Reloads the photo browser and refetches data
- (void)reloadData;
- (void)reloadDataWithPhotos:(NSArray *)photosArray;
- (void)reloadReportBtnTitle:(NSArray<reportObject *> *)reportTitleAry;

// Set page that photo browser starts on
- (void)setInitialPageIndex:(NSUInteger)index;

// Get IDMPhoto at index
- (id<IDMPhoto>)photoAtIndex:(NSUInteger)index;

@end
