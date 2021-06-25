//
//  DetailsPlusViewController.h
//  Flix
//
//  Created by dylanfdl on 6/25/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsPlusViewController : UIViewController

// since each detailed view needs to access the specific movie
@property (nonatomic, strong) NSDictionary *movie;

@end

NS_ASSUME_NONNULL_END
