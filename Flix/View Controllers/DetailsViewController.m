//
//  DetailsViewController.m
//  Flix
//
//  Created by dylanfdl on 6/23/21.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"purp_gradient.png"]]];
    
    // Do any additional setup after loading the view.
    // To be used for both back and main poster
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    
    // main poster url
    NSString *posterURLString = self.movie.posterUrl;
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.posterView setImageWithURL:posterURL];
    self.posterView.layer.cornerRadius = 5;
    
    // back poster url
    NSString *backdropURLString = self.movie.posterUrl;
    NSString *fullbackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    NSURL *backposterURL = [NSURL URLWithString:fullbackdropURLString];
    [self.backdropView setImageWithURL:backposterURL];
    
    // set title
    self.titleLabel.text = self.movie.title;
    [self.titleLabel sizeToFit];
    
    // set synopsis
    self.synopsisLabel.text = self.movie.overview_text;
    [self.synopsisLabel sizeToFit];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
