
#import <UIKit/UIKit.h>


@interface ChatViewCell : UITableViewCell

@property (strong, nonatomic) NSDictionary* chatMessages;
@property (strong, nonatomic) IBOutlet UIImageView *imgForThumbnail;
@property (strong, nonatomic) IBOutlet UILabel *lblForTitle;

@property (strong, nonatomic) IBOutlet UILabel *lblForTitleR;

@property (strong, nonatomic) IBOutlet UILabel *delivered;



@end

