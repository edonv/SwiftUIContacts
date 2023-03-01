//
//  Contacts+Constants.swift
//  
//
//  Created by Edon Valdman on 3/1/23.
//

import Foundation
import Contacts

public struct ContactsConstant: RawRepresentable {
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    // Properties that are always fetched. Can be used with key value coding and observing.
    public static let identifierKey: ContactsConstant = ContactsConstant(rawValue: CNContactIdentifierKey)
    
    // Optional properties that can be fetched. Can be used with key value coding and observing.
    public static let namePrefixKey: ContactsConstant = ContactsConstant(rawValue: CNContactNamePrefixKey)
    public static let givenNameKey: ContactsConstant = ContactsConstant(rawValue: CNContactGivenNameKey)
    public static let middleNameKey: ContactsConstant = ContactsConstant(rawValue: CNContactMiddleNameKey)
    public static let familyNameKey: ContactsConstant = ContactsConstant(rawValue: CNContactFamilyNameKey)
    public static let previousFamilyNameKey: ContactsConstant = ContactsConstant(rawValue: CNContactPreviousFamilyNameKey)
    public static let nameSuffixKey: ContactsConstant = ContactsConstant(rawValue: CNContactNameSuffixKey)
    public static let nicknameKey: ContactsConstant = ContactsConstant(rawValue: CNContactNicknameKey)
    public static let organizationNameKey: ContactsConstant = ContactsConstant(rawValue: CNContactOrganizationNameKey)
    public static let departmentNameKey: ContactsConstant = ContactsConstant(rawValue: CNContactDepartmentNameKey)
    public static let jobTitleKey: ContactsConstant = ContactsConstant(rawValue: CNContactJobTitleKey)
    public static let phoneticGivenNameKey: ContactsConstant = ContactsConstant(rawValue: CNContactPhoneticGivenNameKey)
    public static let phoneticMiddleNameKey: ContactsConstant = ContactsConstant(rawValue: CNContactPhoneticMiddleNameKey)
    public static let phoneticFamilyNameKey: ContactsConstant = ContactsConstant(rawValue: CNContactPhoneticFamilyNameKey)
    public static let phoneticOrganizationNameKey: ContactsConstant = ContactsConstant(rawValue: CNContactPhoneticOrganizationNameKey)
    public static let birthdayKey: ContactsConstant = ContactsConstant(rawValue: CNContactBirthdayKey)
    public static let nonGregorianBirthdayKey: ContactsConstant = ContactsConstant(rawValue: CNContactNonGregorianBirthdayKey)
    public static let noteKey: ContactsConstant = ContactsConstant(rawValue: CNContactNoteKey)
    public static let imageDataKey: ContactsConstant = ContactsConstant(rawValue: CNContactImageDataKey)
    public static let thumbnailImageDataKey: ContactsConstant = ContactsConstant(rawValue: CNContactThumbnailImageDataKey)
    public static let imageDataAvailableKey: ContactsConstant = ContactsConstant(rawValue: CNContactImageDataAvailableKey)
    public static let typeKey: ContactsConstant = ContactsConstant(rawValue: CNContactTypeKey)
    public static let phoneNumbersKey: ContactsConstant = ContactsConstant(rawValue: CNContactPhoneNumbersKey)
    public static let emailAddressesKey: ContactsConstant = ContactsConstant(rawValue: CNContactEmailAddressesKey)
    public static let postalAddressesKey: ContactsConstant = ContactsConstant(rawValue: CNContactPostalAddressesKey)
    public static let datesKey: ContactsConstant = ContactsConstant(rawValue: CNContactDatesKey)
    public static let urlAddressesKey: ContactsConstant = ContactsConstant(rawValue: CNContactUrlAddressesKey)
    public static let relationsKey: ContactsConstant = ContactsConstant(rawValue: CNContactRelationsKey)
    public static let socialProfilesKey: ContactsConstant = ContactsConstant(rawValue: CNContactSocialProfilesKey)
    public static let instantMessageAddressesKey: ContactsConstant = ContactsConstant(rawValue: CNContactInstantMessageAddressesKey)
}
