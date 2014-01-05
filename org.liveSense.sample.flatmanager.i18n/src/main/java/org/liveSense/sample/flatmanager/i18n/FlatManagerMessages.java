package org.liveSense.sample.flatmanager.i18n;

import com.google.gwt.i18n.client.LocalizableResource.Key;
import com.google.gwt.i18n.client.Messages.DefaultMessage;

public interface FlatManagerMessages {

	@Key("test_message")
	@DefaultMessage(value = "Test Default")
	String test_message();

	@Key("modules")
	@DefaultMessage(value = "Modules")
	String modules();

	@Key("third_party_menu")
	String third_party_menu();

	@Key("item_group_menu")
	String item_group_menu();

	@Key("measure_menu")
	String measure_menu();

	@Key("module_menu")
	String module_menu();

	@Key("partner_group_menu")
	String partner_group_menu();

	@Key("payment_type_menu")
	String payment_type_menu();

	@Key("address_type_menu")
	String address_type_menu();

	@Key("currency_menu")
	String currency_menu();

	@Key("invoice_type_menu")
	String invoice_type_menu();

	@Key("invoice_vat_type_menu")
	String invoice_vat_type_menu();

	@Key("note_type_menu")
	String note_type_menu();

	@Key("payment_method_menu")
	String payment_method_menu();

	@Key("global")
	String global();

	@Key("allow_initial_gel_item")
	String allow_initial_gel_item();

	@Key("allow_gel_item")
	String allow_gel_item();

	@Key("allow_closing_gel_item")
	String allow_closing_gel_item();

	@Key("allow_civ")
	String allow_civ();

	@Key("gel_valid_date_from")
	String gel_valid_date_from();

	@Key("gel_valid_date_to")
	String gel_valid_date_to();

	@Key("civ_account")
	String civ_account();

	@Key("civ_revenue_account")
	String civ_revenue_account();

	@Key("civ_vat_account")
	String civ_vat_account();

	@Key("period_menu")
	String period_menu();

	@Key("registry_type_menu")
	String registry_type_menu();

	@Key("registry_menu")
	String registry_menu();

	@Key("transport_type_menu")
	String transport_type_menu();

	@Key("system_currency")
	String system_currency();

	@Key("system_currency_2nd")
	String system_currency_2nd();

	@Key("system_currency_vat")
	String system_currency_vat();

	@Key("printed_code")
	String printed_code();

	@Key("multiplier")
	String multiplier();

	@Key("declaration_multiplier")
	String declaration_multiplier();

	@Key("declaration_percentage")
	String declaration_percentage();

	@Key("source_supplier")
	String source_supplier();

	@Key("source_vendor")
	String source_vendor();

	@Key("target_supplier")
	String target_supplier();

	@Key("target_vendor")
	String target_vendor();

	@Key("declaration_eu_vat")
	String declaration_eu_vat();

	@Key(value = "code_saas_registry_type")
	String code_saas_registry_type();

	@Key(value = "address")
	String address();

	@Key(value = "postal_code")
	String postal_code();

	@Key(value = "city")
	String city();

	@Key(value = "street")
	String street();

	@Key(value = "address_number")
	String address_number();

	@Key(value = "bank_account")
	String bank_account();

	@Key(value = "customer_title")
	String customer_title();

	@Key(value = "customer_first_name")
	String customer_first_name();

	@Key(value = "customer_middle_name")
	String customer_middle_name();

	@Key(value = "customer_last_name")
	String customer_last_name();

	/* Itt */
	@Key(value = "payment_method")
	String payment_method();

	@Key(value = "registry")
	String registry();

	@Key(value = "currency")
	String currency();

	@Key(value = "quantity")
	String quantity();

	@Key(value = "measure")
	String measure();

	@Key(value = "unit_price")
	String unit_price();

	@Key(value = "vat")
	String vat();

	@Key(value = "desciption")
	String desciption();

	@Key(value = "net_amount")
	String net_amount();

	@Key(value = "vat_amount")
	String vat_amount();

	@Key(value = "gross_amount")
	String gross_amount();

	@Key(value = "storno_flag")
	String storno_flag();

	@Key(value = "tax_number")
	String tax_number();

	@Key(value = "eu_tax_number")
	String eu_tax_number();

	@Key(value = "recipient")
	String recipient();

	@Key(value = "booking_date")
	String booking_date();

	@Key(value = "item_code")
	String item_code();

	@Key(value = "partner_type")
	String partner_type();

	@Key(value = "swift_code")
	String swift_code();

	@Key(value = "person")
	String person();

	@Key(value = "company")
	String company();

	@Key(value = "bank")
	String bank();

	@Key(value = "address_type")
	String address_type();

	@Key(value = "country")
	String country();

	@Key(value = "addresses")
	String addresses();

	@Key(value = "bank_accounts")
	String bank_accounts();

	@Key(value = "name")
	String name();

	@Key(value = "type")
	String type();

	@Key(value = "code")
	String code();

	@Key(value = "new_address")
	String new_address();

	@Key(value = "new_partner")
	String new_partner();

	@Key(value = "new_partner_is_automatically_created")
	String new_partner_is_automatically_created();

	@Key(value = "supplier_account")
	String supplier_account();

	@Key(value = "vendor_account")
	String vendor_account();

	@Key(value = "own_data")
	String own_data();

	@Key(value = "own_main_address_data")
	String own_main_address_data();

	@Key(value = "own_account_data")
	String own_account_data();

	@Key(value = "measures")
	String measures();

	@Key(value = "vats")
	String vats();

	@Key(value = "new_item")
	String new_item();

	@Key(value = "new_item_is_automatically_created")
	String new_item_is_automatically_created();

	@Key(value = "new_address_info")
	String new_address_info();

	@Key(value = "initial_data_info_message")
	String initial_data_info_message();
	
	@Key(value = "slingresult_exception_accessdenied")
	String slingresult_exception_accessdenied();
	
	@Key(value = "slingresult_exception_constraintviolation")
	String slingresult_exception_constraintviolation();

	@Key(value = "slingresult_exception_lock")
	String slingresult_exception_lock();

	@Key(value = "slingresult_exception_pathnotfound")
	String slingresult_exception_pathnotfound();

	@Key(value = "slingresult_exception_itemexists")
	String slingresult_exception_itemexists();

	@Key(value = "slingresult_exception_itemnotfound")
	String slingresult_exception_itemnotfound();

	@Key(value = "slingresult_exception_nosuchnodetype")
	String slingresult_exception_nosuchnodetype();

	@Key(value = "slingresult_exception_unsupportedencoding")
	String slingresult_exception_unsupportedencoding();

	@Key(value = "saas_ok")
	String saas_ok();

	@Key(value = "saas_error")
	String saas_error();

	@Key(value = "saas_saveok")
	String saas_saveok();

	@Key(value = "saas_saveerror")
	String saas_saveerror();

	@Key(value = "saas_sendok")
	String saas_sendok();

	@Key(value = "saas_senderror")
	String saas_senderror();

	@Key(value = "saas_imagerefresherror")
	String saas_imagerefresherror();
	
	@Key(value = "saas_communicationerror")
	String saas_communicationerror();

	@Key(value = "saas_addresstype_postal")
	String saas_addresstype_postal();

	@Key(value = "saas_addresstype_main")
	String saas_addresstype_main();

	@Key(value = "saas_address_type")
	String saas_address_type();

	@Key(value = "saas_address_name")
	String saas_address_name();

	@Key(value = "saas_address_postalcode")
	String saas_address_postalcode();

	@Key(value = "saas_address_city")
	String saas_address_city();

	@Key(value = "saas_address_street")
	String saas_address_street();

	@Key(value = "saas_address_number")
	String saas_address_number();

	@Key(value = "saas_contact_firstname")
	String saas_contact_firstname();

	@Key(value = "saas_contact_lastname")
	String saas_contact_lastname();

	@Key(value = "saas_contact_phonenumber")
	String saas_contact_phonenumber();

	@Key(value = "saas_contact_email")
	String saas_contact_email();

	@Key(value = "saas_contact_url")
	String saas_contact_url();

	@Key(value = "signup_error_activationServiceNotAvailable")
	String signup_error_activationServiceNotAvailable();

	@Key(value = "signup_error_configuratorServiceNotAvailable")
	String signup_error_configuratorServiceNotAvailable();

	@Key(value = "signup_error_ConstraintViolationException")
	String signup_error_ConstraintViolationException(String msg);

	@Key(value = "signup_error_emailCantStartWithDotOrAt")
	String signup_error_emailCantStartWithDotOrAt();

	@Key(value = "signup_error_emailCantStartWithWww")
	String signup_error_emailCantStartWithWww();

	@Key(value = "signup_error_emailConfirmNotMatch")
	String signup_error_emailConfirmNotMatch();

	@Key(value = "signup_error_emailIllegalCharacter")
	String signup_error_emailIllegalCharacter();

	@Key(value = "signup_error_emailIsNull")
	String signup_error_emailIsNull();

	@Key(value = "signup_error_emailServiceNotAvailable")
	String signup_error_emailServiceNotAvailable();

	@Key(value = "signup_error_illegalAccessException")
	String signup_error_illegalAccessException(String msg);

	@Key(value = "signup_error_illegalCharacterInUserName")
	String signup_error_illegalCharacterInUserName();

	@Key(value = "signup_error_instantiationException")
	String signup_error_instantiationException(String msg);

	@Key(value = "signup_error_internalError")
	String signup_error_internalError(String msg);

	@Key(value = "signup_error_InvocationTargetException")
	String signup_error_InvocationTargetException(String msg);

	@Key(value = "signup_error_IOException")
	String signup_error_IOException(String msg);

	@Key(value = "signup_error_LockException")
	String signup_error_LockException(String msg);

	@Key(value = "signup_error_NoSuchMethodException")
	String signup_error_NoSuchMethodException(String msg);

	@Key(value = "signup_error_passwordConfirmNotMatch")
	String signup_error_passwordConfirmNotMatch();

	@Key(value = "signup_error_passwordIsNull")
	String signup_error_passwordIsNull();

	@Key(value = "signup_error_passwordIsTooShort")
	String signup_error_passwordIsTooShort();

	@Key(value = "signup_error_pathNotFound")
	String signup_error_pathNotFound(String msg);

	@Key(value = "signup_error_principalNotExsists")
	String signup_error_principalNotExsists(String msg);

	@Key(value = "signup_error_theUserAlreadyExists")
	String signup_error_theUserAlreadyExists(String msg);

	@Key(value = "signup_error_userManagerServiceNotAvailable")
	String signup_error_userManagerServiceNotAvailable();

	@Key(value = "signup_error_userNameIsNull")
	String signup_error_userNameIsNull();

	@Key(value = "signup_error_userNameIsTooShort")
	String signup_error_userNameIsTooShort();

	@Key(value = "signup_error_userNotExistsException")
	String signup_error_userNotExistsException(String msg);

	@Key(value = "signup_error_ValueFormatException")
	String signup_error_ValueFormatException(String msg);

	@Key(value = "signup_error_VersionException")
	String signup_error_VersionException(String msg);

	@Key(value = "signup_error_youHaveToAcceptTermsAndConditions")
	String signup_error_youHaveToAcceptTermsAndConditions();

	@Key(value = "signup_error_activationCodeIsEmpty")
	String signup_error_activationCodeIsEmpty();

	@Key(value = "signup_error_activationCodeIsInvalid")
	String signup_error_activationCodeIsInvalid();

	@Key(value = "signup_error_invalidActivationPartner")
	String signup_error_invalidActivationPartner(String partnerPath);

	@Key(value = "signup_error_activationRepsoitoryError")
	String signup_error_activationRepsoitoryError(String message);

	@Key(value = "signup_error_unknownError")
	String signup_error_unknownError(String message);

	@Key(value = "signup_error_groupRegisteredWithThisName")
	String signup_error_groupRegisteredWithThisName(String string);

	@Key(value = "signup_error_theFullNameIsNull")
	String signup_error_theFullNameIsNull();

	@Key(value = "saas_addresstype_seat")
	String saas_addresstype_seat();

	@Key(value = "saas_addresstype_site")
	String saas_addresstype_site();

	@Key(value = "saas_addresstype_other")
	String saas_addresstype_other();

	@Key(value = "saas_contact_position")
	String saas_contact_position();

	@Key(value = "saas_back_button_question")
	String saas_back_button_question();

	@Key(value = "changepassword_error_configuratorServiceNotAvailable")
	String changepassword_error_configuratorServiceNotAvailable();

	@Key(value = "changepassword_error_activationServiceNotAvailable")
	String changepassword_error_activationServiceNotAvailable();

	@Key(value = "changepassword_error_userManagerServiceNotAvailable")
	String changepassword_error_userManagerServiceNotAvailable();

	@Key(value = "changepassword_error_emailServiceNotAvailable")
	String changepassword_error_emailServiceNotAvailable();

	@Key(value = "changepassword_error_userNameIsEmpty")
	String changepassword_error_userNameIsEmpty();

	@Key(value = "changepassword_error_activationCodeIsEmpty")
	String changepassword_error_activationCodeIsEmpty();

	@Key(value = "changepassword_error_invalidActivation")
	String changepassword_error_invalidActivation();

	@Key(value = "changepassword_error_userNotExists")
	String changepassword_error_userNotExists(String userName);

	@Key(value = "changepassword_error_principalIsNotUser")
	String changepassword_error_principalIsNotUser(String userName);

	@Key(value = "changepassword_error_ValueFormatException")
	String changepassword_error_ValueFormatException(String string);

	@Key(value = "changepassword_error_VersionException")
	String changepassword_error_VersionException(String string);

	@Key(value = "changepassword_error_LockException")
	String changepassword_error_LockException(String string);

	@Key(value = "changepassword_error_ConstraintViolationException")
	String changepassword_error_ConstraintViolationException(String string);

	@Key(value = "changepassword_error_internalError")
	String changepassword_error_internalError(String string);

	@Key(value = "changepassword_error_userNameOrPasswordIsIncorrect")
	String changepassword_error_userNameOrPasswordIsIncorrect();

	@Key(value = "changepassword_error_userIsInvalid")
	String changepassword_error_userIsInvalid();

	@Key(value = "changePassword_error_cannotSendEmail")
	String changePassword_error_cannotSendEmail(String string);

	@Key(value = "changepassword_error_PrincipalNotExistsException")
	String changepassword_error_PrincipalNotExistsException(String userName);

	@Key(value = "changepassword_error_resetCodeIsEmpty")
	String changepassword_error_resetCodeIsEmpty();

	@Key(value = "changepassword_error_passwordIsEmpty")
	String changepassword_error_passwordIsEmpty();

	@Key(value = "changepassword_error_passwordConfirmIsEmpty")
	String changepassword_error_passwordConfirmIsEmpty();

	@Key(value = "changepassword_error_passwordConfirmNotMatch")
	String changepassword_error_passwordConfirmNotMatch();

	@Key(value = "changepassword_error_invalidReset")
	String changepassword_error_invalidReset();

	@Key(value = "changepassword_error_invalidUserEmailAddress")
	String changepassword_error_invalidUserEmailAddress();

	@Key(value = "changepassword_error_passwordIsTooShort")
	String changepassword_error_passwordIsTooShort();

	@Key(value = "saas_payment_title")
	String saas_payment_title();

	@Key(value = "saas_payment_amount")
	String saas_payment_amount();

	@Key(value = "saas_payment_expiration")
	String saas_payment_expiration();

	@Key(value = "saas_payment_delivery")
	String saas_payment_delivery();

	@Key(value = "saas_payment_period_start")
	String saas_payment_period_start();

	@Key(value = "saas_payment_end")
	String saas_payment_end();

	@Key(value = "saas_payment_type")
	String saas_payment_type();

	@Key(value = "saas_payment_invoice_date")
	String saas_payment_invoice_date();

	@Key(value = "saas_payment_invoice_id")
	String saas_payment_invoice_id();

	@Key(value = "saas_payment_storno")
	String saas_payment_storno();

	@Key(value = "contactus_error_userIsInvalid")
	String contactus_error_userIsInvalid();

	@Key(value = "contactus_error_emailIsNull")
	String contactus_error_emailIsNull();

	@Key(value = "contactus_error_userNameIsEmpty")
	String contactus_error_userNameIsEmpty();

	@Key(value = "contactus_error_theFullNameIsNull")
	String contactus_error_theFullNameIsNull();

	@Key(value = "contactus_error_emailCantStartWithDotOrAt")
	String contactus_error_emailCantStartWithDotOrAt();

	@Key(value = "contactus_error_emailCantStartWithWww")
	String contactus_error_emailCantStartWithWww();

	@Key(value = "contactus_error_emailIllegalCharacter")
	String contactus_error_emailIllegalCharacter();

	@Key(value = "contactus_error_illegalCharacterInUserName")
	String contactus_error_illegalCharacterInUserName();

	@Key(value = "contactus_error_userNameIsTooShort")
	String contactus_error_userNameIsTooShort();

	@Key(value = "contactus_error_userNameIsNull")
	String contactus_error_userNameIsNull();

	@Key(value = "contactus_error_cannotSendEmail")
	String contactus_error_cannotSendEmail(String string);

	@Key(value = "contactus_error_PrincipalNotExistsException")
	String contactus_error_PrincipalNotExistsException(String userName);

	@Key(value = "contactus_error_internalError")
	String contactus_error_internalError(String string);

	@Key(value = "contactus_error_ValueFormatException")
	String contactus_error_ValueFormatException(String string);

	@Key(value = "contactus_error_VersionException")
	String contactus_error_VersionException(String string);

	@Key(value = "contactus_error_LockException")
	String contactus_error_LockException(String string);

	@Key(value = "contactus_error_ConstraintViolationException")
	String contactus_error_ConstraintViolationException(String string);

	@Key(value = "captcha_code_is_invalid")
	String captcha_code_is_invalid();

	@Key(value = "communicationError")
	String communicationError();

	@Key(value = "logout")
	String logout();

	@Key(value = "loggedInAs")
	String loggedInAs();

	@Key(value = "login")
	String login();

	@Key(value = "userName")
	String userName();

	@Key(value = "password")
	String password();

	@Key(value = "contentEditorEdit")
	String contentEditorEdit();

	@Key(value = "contentEditorSave")
	String contentEditorSave();

	@Key(value = "contentEditorExit")
	String contentEditorExit();

	@Key(value = "contentEditorSaveSuccesfull")
	String contentEditorSaveSuccesfull();

	@Key(value = "recommedationDoesNotMatch")
	String recommedation_error_recommendationNotFound();

	@Key(value = "recommedation_error_businessIsNull")
	String recommedation_error_businessIsNull();

	@Key(value = "recommedation_error_incomeIsNull")
	String recommedation_error_incomeIsNull();

	@Key(value = "recommedation_error_employeeIsNull")
	String recommedation_error_employeeIsNull();

	@Key(value = "period_type")
	String period_type();

	@Key(value = "period_type_once")
	String period_type_once();

	@Key(value = "period_type_monthly")
	String period_type_monthly();

	@Key(value = "price_type")
	String price_type();

	@Key(value = "price")
	String price();

	@Key(value = "price_valid_from")
	String price_valid_from();

	@Key(value = "price_valid_to")
	String price_valid_to();

	@Key(value = "price_user_from")
	String price_user_from();

	@Key(value = "price_type_base")
	String price_type_base();

	@Key(value = "price_type_education")
	String price_type_education();

	@Key(value = "price_type_supplement")
	String price_type_supplement();

	@Key(value = "url")
	String url();

	@Key(value = "module_is_mandatory_in_product")
	String module_is_mandatory_in_product();

	@Key(value = "packages")
	String packages();

	@Key(value = "product")
	String product();

	@Key(value = "contract_status")
	String contract_status();

	@Key(value = "constract_code")
	String constract_code();

	@Key(value = "contract_date")
	String contract_date();

	@Key(value = "parent_contract_code")
	String parent_contract_code();

	@Key(value = "contract_valid_from")
	String contract_valid_from();

	@Key(value = "contract_valid_to")
	String contract_valid_to();

	@Key(value = "contract_status_offer")
	String contract_status_offer();

	@Key(value = "contract_status_contract")
	String contract_status_contract();

	@Key(value = "contract_status_expired")
	String contract_status_expired();

	@Key(value = "contract_status_terminated")
	String contract_status_terminated();

	@Key(value = "module")
	String module();

	@Key(value = "signup_error_captchaCodeIsEmpty")
	String signup_error_captchaCodeIsEmpty();

}
