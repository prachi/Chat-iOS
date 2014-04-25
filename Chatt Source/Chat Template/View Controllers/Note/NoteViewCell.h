
#import <UIKit/UIKit.h>


@interface NoteViewCell : UITableViewCell
{
    IBOutlet UIImageView*       imgForThumbnail ;
    IBOutlet UILabel*           lblForTitle ;
}

+ ( NoteViewCell* ) sharedCell ;
- ( void ) setThumbnail : ( UIImage* ) thumbnail ;
- ( void ) setTitle : ( NSString* ) title ;

@end
