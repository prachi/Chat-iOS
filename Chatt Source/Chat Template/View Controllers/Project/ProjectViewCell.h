
#import <UIKit/UIKit.h>


@interface ProjectViewCell : UITableViewCell
{
    IBOutlet UIImageView*       imgForThumbnail ;
    IBOutlet UILabel*           lblForTitle ;
}


+ ( ProjectViewCell* ) sharedCell ;
- ( void ) setThumbnail : ( UIImage* ) thumbnail ;
- ( void ) setTitle : ( NSString* ) title ;

@end
