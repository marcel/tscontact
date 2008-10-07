#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif
#import <AddressBook/AddressBook.h>

@interface TSContact : NSObject {
    ABAddressBookRef _addressBook;
    ABRecordID _recordId;
    ABRecordRef _recordRef;
    NSString *_fullName;
}
- (id)initWithId:(ABRecordID)recordId;
- (id)initWithRef:(ABRecordRef)recordRef;
- (NSString *)fullName;
@end
