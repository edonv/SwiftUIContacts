# SwiftUIContacts

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fedonv%2FSwiftUIContacts%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/edonv/SwiftUIContacts)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fedonv%2FSwiftUIContacts%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/edonv/SwiftUIContacts)

`SwiftUI` wrapper of [ContactsUI](https://developer.apple.com/documentation/contactsui)'s  [CNContactPickerViewController](https://developer.apple.com/documentation/contactsui/cncontactpickerviewcontroller). Eventually, I'll add the rest of the framework. 

## Documentation

Documentation for `SwiftUIContacts` is hosted on [Swift Package Index](https://swiftpackageindex.com/edonv/SwiftUIContacts/documentation/swiftuicontacts).

## ContactPicker

`ContactPicker` supports four different selection modes and the mode is decided by which `init` you use:
- A single contact 
  - Use a `@Binding` of type `CNContact?` in the `init`
- Multiple contacts 
  - Use a `@Binding` of type `[CNContact]` in the `init`
- A single property of a contact 
  - Use a `@Binding` of type `CNContactProperty?` in the `init`
- A single property from multiple contacts 
  - Use a `@Binding` of type `[CNContactProperty]` in the `init`

```swift
.sheet(isPresented: $showSheet) {
    ContactPicker(selection: $selectedProperty,
                  displayedPropertyKeys: [.phoneNumbersKey]
    )
}
```
