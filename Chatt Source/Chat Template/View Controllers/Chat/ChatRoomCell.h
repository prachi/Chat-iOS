
#import <UIKit/UIKit.h>


@interface ChatRoomCell : UITableViewCell
{
    @public
    IBOutlet UILabel *lastMessage;
    IBOutlet UILabel *date;
    IBOutlet UIImageView* imgForThumbnail ;
    IBOutlet UILabel* lblForTitle ;
}


+ ( ChatRoomCell* ) sharedCell ;
- ( void ) setThumbnail : ( UIImage* ) thumbnail ;
- ( void ) setTitle : ( NSString* ) title ;

@end



