//
//  MoviesViewController.m
//  Flix
//
//  Created by dylanfdl on 6/23/21.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Movie.h"
#import "MovieApiManager.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
// In Objective-C, @property creates a private instance variable and also automatically creates a getter and setter method for you
// nonatomic and strong specify how the compiler should generate the getter and setter method
// strong means this variable will retain its value over time ? (wasn't explained clearly)
// nonatomic - this will be common for us (also wasn't explained)
@property (nonatomic, strong) NSMutableArray *movies;
@property (nonatomic, strong) NSMutableArray *filteredMovies;

// UIRefreshControl is an object that handles refreshing
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarLabel;


@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"purp_gradient.png"]]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_background"] forBarMetrics:UIBarMetricsDefault];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBarLabel.delegate = self;
    // Do any additional setup after loading the view.
    
    // start Animating while fetch movies is happening
    [self.loadingIndicator startAnimating];
    MovieApiManager *manager = [MovieApiManager new];
    [manager fetchNowPlaying:^(NSArray *movies, NSError *error) {
        self.movies = movies;
        self.filteredMovies = self.movies;
        [self.tableView reloadData];
    }];
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredMovies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // IMPORTANT LINE
    // Alloc vs init ?
    // Alloc actually creates space for something in memory
    // Init brings this said memory into your Storyboard
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    // Set movies was being implicitly called
    cell.movie = self.filteredMovies[indexPath.row];
    
    cell.posterView.layer.cornerRadius = 5;
    [self.loadingIndicator stopAnimating];
    return cell;
}

// for search bar
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        
        // checks if title contains a char
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(title CONTAINS[cd] %@)", searchText];
        self.filteredMovies = [self.movies filteredArrayUsingPredicate:predicate];
        NSLog(@"%@", self.filteredMovies);
                
    }
    else {
        self.filteredMovies = self.movies;
    }
    
    [self.tableView reloadData];
 
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBarLabel.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBarLabel.showsCancelButton = NO;
    self.searchBarLabel.text = @"";
    [self.searchBarLabel resignFirstResponder];
    [self.tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell *tappedCell = sender;
    // Finding index path to access the dict row
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    Movie *movie = self.movies[indexPath.row];
    
    DetailsViewController *detailViewController = [segue destinationViewController];
    detailViewController.movie = movie;
}


@end
