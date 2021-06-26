//
//  DetailsPlusViewController.m
//  Flix
//
//  Created by dylanfdl on 6/25/21.
//

#import "DetailsPlusViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TrailerViewController.h"

@interface DetailsPlusViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundShape;
@property (weak, nonatomic) IBOutlet UILabel *langLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonTriggerModal;


@end

@implementation DetailsPlusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Somehow this set every background... not sure why this applies to every viewController, but maybe I'll learn why at some point
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"purp_gradient.png"]]];
    // rounded corners for backgroundShape
    //self.backgroundShape.clipsToBounds = TRUE;
    self.backgroundShape.layer.cornerRadius = 5;
    
    // Do any additional setup after loading the view.
    // To be used for both back and main poster
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    
    /*// main poster url
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.posterView setImageWithURL:posterURL];*/
    
    // back poster url
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullbackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    NSURL *backposterURL = [NSURL URLWithString:fullbackdropURLString];
    [self.backdropView setImageWithURL:backposterURL];
    //self.backdropView.layer
    
    // set title
    self.titleLabel.text = self.movie[@"title"];
    [self.titleLabel setText:[self.titleLabel.text uppercaseString]];
    [self.titleLabel sizeToFit];
    
    // set synopsis
    self.synopsisLabel.text = self.movie[@"overview"];
    [self.synopsisLabel sizeToFit];
    
    // set release data
    self.releaseDateLabel.text = self.movie[@"release_date"];
    [self.releaseDateLabel sizeToFit];
    
    // set lang
    self.langLabel.text = self.movie[@"original_language"];
    [self.langLabel setText:[self.langLabel.text uppercaseString]];
    [self.langLabel sizeToFit];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    // Finding index path to access the dict row
    NSString *c_id = self.movie[@"id"];
    
    TrailerViewController *trailerViewController = [segue destinationViewController];
    trailerViewController.customID = c_id;
    
}


@end
