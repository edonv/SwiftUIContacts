//
//  ContactPicker.swift
//  
//
//  Created by Edon Valdman on 3/1/23.
//

#if os(iOS) || targetEnvironment(macCatalyst)

import SwiftUI
import ContactsUI
import Contacts

/// A view that displays an interface for picking contacts.
///
/// A `ContactPicker` allows the user to select one or more contacts (or their properties) from the list of contacts displayed in the contact view controller ([CNContactViewController](https://developer.apple.com/documentation/contactsui/cncontactviewcontroller)). The picker supports both single selection and multiselection of the contacts. The app using `ContactPicker` does not need access to the user’s contacts and the user will not be prompted for “grant permission” access. The app has access only to the user’s final selection.
///
/// There are predefined predicates in this view that let you control the user selection of the contact. Changing the predicates only take effect before the view is presented.
///
/// A `SwiftUI` wrapper for [CNContactPickerViewController](https://developer.apple.com/documentation/contactsui/cncontactpickerviewcontroller).
@available(iOS 13.0, macCatalyst 13.1, *)
public struct ContactPicker: View {
    public let selectMode: SelectMode
    
    @Binding public var selectedContact: CNContact?
    @Binding public var selectedContacts: [CNContact]
    @Binding public var selectedProperty: CNContactProperty?
    @Binding public var selectedProperties: [CNContactProperty]
    public var displayedPropertyKeys: [ContactsConstant]?
    
    private var predicateForEnablingContact: NSPredicate? = nil
    private var predicateForSelectionOfContact: NSPredicate? = nil
    private var predicateForSelectionOfProperty: NSPredicate? = nil
    
    /// Creates a ``ContactPicker`` `View` in ``ContactPicker/SelectMode-swift.enum/multipleContacts`` select mode.
    /// - Parameters:
    ///   - selectedContacts: A binding to a property that reflects the selected contacts.
    public init(selection selectedContacts: Binding<[CNContact]>) {
        self.selectMode = .multipleContacts

        self._selectedContacts = selectedContacts
        
        self._selectedContact = .constant(nil)
        self._selectedProperty = .constant(nil)
        self._selectedProperties = .constant([])
        
        self.displayedPropertyKeys = nil
    }
    
    /// Creates a ``ContactPicker`` `View` in ``ContactPicker/SelectMode-swift.enum/singleContact`` select mode.
    /// - Parameters:
    ///   - selectedContact: A binding to a property that reflects the selected contact.
    public init(selection selectedContact: Binding<CNContact?>) {
        self.selectMode = .singleContact
        
        self._selectedContact = selectedContact
        
        self._selectedContacts = .constant([])
        self._selectedProperty = .constant(nil)
        self._selectedProperties = .constant([])
        
        self.displayedPropertyKeys = nil
    }
    
    /// Creates a ``ContactPicker`` `View` in ``ContactPicker/SelectMode-swift.enum/multipleProperties`` select mode.
    ///
    /// > Warning: This version of ``ContactPicker`` is volatile and hasn't been subject to siginificant testing as of yet. It seems that the underlying `CNContactPickerViewController` has the same issues when being used in this mode.
    /// - Parameters:
    ///   - selectedProperties: A binding to a property that reflects the selected contact properties.
    ///   - propertyKey: A `CNContact` property key that will be selected for all chosen contacts.
    public init(selection selectedProperties: Binding<[CNContactProperty]>, propertyKey: String) {
        self.selectMode = .multipleProperties
        
        self._selectedProperties = selectedProperties
        
        self._selectedContact = .constant(nil)
        self._selectedContacts = .constant([])
        self._selectedProperty = .constant(nil)
        
        self.displayedPropertyKeys = nil
        
        self.setPredicateForSelectionOfProperty(
            NSPredicate(format: "(key == '\(propertyKey)')")
        )
    }
    
    /// Creates a ``ContactPicker`` `View` in ``ContactPicker/SelectMode-swift.enum/multipleProperties`` select mode.
    ///
    /// > Warning: This version of ``ContactPicker`` is volatile and hasn't been subject to siginificant testing as of yet. It seems that the underlying `CNContactPickerViewController` has the same issues when being used in this mode.
    /// - Parameters:
    ///   - selectedProperties: A binding to a property that reflects the selected contact properties.
    ///   - propertyKey: A ``ContactsConstant`` that will be selected for all chosen contacts.
    public init(selection selectedProperties: Binding<[CNContactProperty]>, propertyKey: ContactsConstant) {
        self.init(selection: selectedProperties, propertyKey: propertyKey.rawValue)
    }
    
    /// Creates a ``ContactPicker`` `View` in ``ContactPicker/SelectMode-swift.enum/singleProperty`` select mode.
    /// - Parameters:
    ///   - selectedProperty: A binding to a property that reflects the selected contact property.
    ///   - displayedPropertyKeys: The [CNContact](https://developer.apple.com/documentation/contacts/cncontact) property keys to display in the contact detail card. All the properties of the contact are displayed if this property is not set
    public init(selection selectedProperty: Binding<CNContactProperty?>, displayedPropertyKeys: [ContactsConstant]? = nil) {
        self.selectMode = .singleProperty
        
        self._selectedProperty = selectedProperty
        
        self._selectedContact = .constant(nil)
        self._selectedContacts = .constant([])
        self._selectedProperties = .constant([])
        
        self.displayedPropertyKeys = displayedPropertyKeys
    }
    
    internal mutating func setPredicateForEnablingContact(_ predicate: NSPredicate) {
        self.predicateForEnablingContact = predicate
    }
    
    internal mutating func setPredicateForSelectionOfContact(_ predicate: NSPredicate) {
        self.predicateForSelectionOfContact = predicate
    }
    
    internal mutating func setPredicateForSelectionOfProperty(_ predicate: NSPredicate) {
        self.predicateForSelectionOfProperty = predicate
    }
}

extension ContactPicker: UIViewControllerRepresentable {
    public func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        picker.displayedPropertyKeys = self.displayedPropertyKeys?.map(\.rawValue)
        
        // MARK: Adding Predicates
        picker.predicateForEnablingContact = self.predicateForEnablingContact
        picker.predicateForSelectionOfContact = self.predicateForSelectionOfContact
        picker.predicateForSelectionOfProperty = self.predicateForSelectionOfProperty
        
        return picker
    }
    
    public func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {
        
    }
    
    public func makeCoordinator() -> CNContactPickerDelegate {
        switch selectMode {
        case .singleContact:
            return SingleContactSelectCoordinator(self)
        case .multipleContacts:
            return MultipleContactSelectCoordinator(self)
        case .singleProperty:
            return SinglePropertySelectCoordinator(self)
        case .multipleProperties:
            return MultiplePropertiesSelectCoordinator(self)
        }
    }
}

extension ContactPicker {
    public enum SelectMode {
        case singleContact
        case multipleContacts
        case singleProperty
        case multipleProperties
    }
    
    /// A basic coordinator delegate for ``ContactPicker``. Used as a base type for variations with each delegate function.
    /// Includes property for the parent `View`, a shared initializer, and an implementation of [contactPickerDidCancel(_:)](https://developer.apple.com/documentation/contactsui/cncontactpickerdelegate/1619204-contactpickerdidcancel).
    public class PickerCoordinator: NSObject, CNContactPickerDelegate {
        internal var parent: ContactPicker
        
        internal init(_ parent: ContactPicker) {
            self.parent = parent
        }
        
        public func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            picker.dismiss(animated: true)
        }
    }
    
    /// A subclass of ``ContactPicker/PickerCoordinator`` used for ``ContactPicker/SelectMode-swift.enum/singleContact`` select mode.
    public class SingleContactSelectCoordinator: PickerCoordinator {
        public func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            parent.selectedContact = contact
        }
    }
    
    /// A subclass of ``ContactPicker/PickerCoordinator`` used for ``ContactPicker/SelectMode-swift.enum/multipleContacts`` select mode.
    public class MultipleContactSelectCoordinator: PickerCoordinator {
        public func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
            parent.selectedContacts = contacts
        }
    }
    
    /// A subclass of ``ContactPicker/PickerCoordinator`` used for ``ContactPicker/SelectMode-swift.enum/singleProperty`` select mode.
    public class SinglePropertySelectCoordinator: PickerCoordinator {
        public func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
            parent.selectedProperty = contactProperty
        }
    }
    
    /// A subclass of ``ContactPicker/PickerCoordinator`` used for ``ContactPicker/SelectMode-swift.enum/multipleProperties`` select mode.
    public class MultiplePropertiesSelectCoordinator: PickerCoordinator {
        public func contactPicker(_ picker: CNContactPickerViewController, didSelectContactProperties contactProperties: [CNContactProperty]) {
            parent.selectedProperties = contactProperties
        }
    }
}

struct ContactPicker_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var showSheet = false
        
        @State var selectedProperty: CNContactProperty? = nil
        
        var body: some View {
            VStack {
                Text((selectedProperty?.value as? String) ?? "No Property Selected")
                    .padding()
                
                Button("Show Sheet") {
                    showSheet = true
                }
            }
            .sheet(isPresented: $showSheet) {
                ContactPicker(selection: $selectedProperty,
                              displayedPropertyKeys: [.phoneNumbersKey]
                )
                .filterSelectableProperties(with:
                    NSPredicate(format: "(key == 'phoneNumber')")
                )
            }
        }
    }
}

#endif
