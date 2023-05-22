//
//  SecureStorage.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 22.05.2023.
//

import Foundation
import Security
import SwiftUI

class SecureStorage {
	enum KeychainError: Error {
		case itemAlreadyExist
		case itemNotFound
		case errorStatus(String?)
		
		init(status: OSStatus) {
			switch status {
			case errSecDuplicateItem:
				self = .itemAlreadyExist
			case errSecItemNotFound:
				self = .itemNotFound
			default:
				let message = SecCopyErrorMessageString(status, nil) as String?
				self = .errorStatus(message)
			}
		}
	}
	
	func addItem(query: [CFString: Any]) throws {
		let status = SecItemAdd(query as CFDictionary, nil)
		
		if status != errSecSuccess {
			throw KeychainError(status: status)
		}
	}
	
	func findItem(query: [CFString: Any]) throws -> [CFString: Any]? {
		var query = query
		query[kSecReturnAttributes] = kCFBooleanTrue
		query[kSecReturnData] = kCFBooleanTrue
		
		var searchResult: AnyObject?
		
		let status = withUnsafeMutablePointer(to: &searchResult) {
			SecItemCopyMatching(query as CFDictionary, $0)
		}
		
		if status != errSecSuccess {
			throw KeychainError(status: status)
		} else {
			return searchResult as? [CFString: Any]
		}
	}
	
	func updateItem(query: [CFString: Any], attributesToUpdate: [CFString: Any]) throws {
		let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
		
		if status != errSecSuccess {
			throw KeychainError(status: status)
		}
	}
	
	func deleteItem(query: [CFString: Any]) throws {
		let status = SecItemDelete(query as CFDictionary)
		
		if status != errSecSuccess {
			throw KeychainError(status: status)
		}
	}
}

extension SecureStorage {
	struct Credentials {
		var login: String
		var password: String
		
		init(login: String, password: String) {
			self.login = login
			self.password = password
		}
	}
	
	func addCredentials(_ credentials: Credentials, with label: String) {
		var query: [CFString: Any] = [:]
		query[kSecClass] = kSecClassGenericPassword
		query[kSecAttrLabel] = label
		query[kSecAttrAccount] = credentials.login
		query[kSecValueData] = credentials.password.data(using: .utf8)
		
		do {
			try addItem(query: query)
		} catch {
			return
		}
	}
	
	func updateCredentials(_ credentials: Credentials, with label: String) {
		deleteCredentials(with: label)
		addCredentials(credentials, with: label)
	}
	
	func getCredentials(with label: String) -> Credentials? {
		var query: [CFString: Any] = [:]
		query[kSecClass] = kSecClassGenericPassword
		query[kSecAttrLabel] = label
		
		var result: [CFString: Any]?
		
		do {
			result = try findItem(query: query)
		} catch {
			return nil
		}
		
		if let account = result?[kSecAttrAccount] as? String,
			 let data = result?[kSecValueData] as? Data,
			 let password = String(data: data, encoding: .utf8) {
			return Credentials(login: account, password: password)
		} else {
			return nil
		}
	}
	
	func deleteCredentials(with label: String) {
		var query: [CFString: Any] = [:]
		query[kSecClass] = kSecClassGenericPassword
		query[kSecAttrLabel] = label
		
		do {
			try deleteItem(query: query)
		} catch {
			return
		}
	}
}

extension SecureStorage {
	func addPassword(_ password: String, for account: String) {
		var query: [CFString: Any] = [:]
		query[kSecClass] = kSecClassGenericPassword
		query[kSecAttrAccount] = account
		query[kSecValueData] = password.data(using: .utf8)
		
		do {
			try addItem(query: query)
		} catch {
			return
		}
	}
	
	func updatePassword(_ password: String, for account: String) {
		guard let _ = getPassword(for: account) else {
			addPassword(password, for: account)
			return
		}
		
		var query: [CFString: Any] = [:]
		query[kSecClass] = kSecClassGenericPassword
		query[kSecAttrAccount] = account
		
		var attributesToUpdate: [CFString: Any] = [:]
		attributesToUpdate[kSecValueData] = password.data(using: .utf8)
		
		do {
			try updateItem(query: query, attributesToUpdate: attributesToUpdate)
		} catch {
			return
		}
	}
	
	func getPassword(for account: String) -> String? {
		var query: [CFString: Any] = [:]
		query[kSecClass] = kSecClassGenericPassword
		query[kSecAttrAccount] = account
		
		var result: [CFString: Any]?
		
		do {
			result = try findItem(query: query)
		} catch {
			return nil
		}
		
		if let data = result?[kSecValueData] as? Data {
			return String(data: data, encoding: .utf8)
		} else {
			return nil
		}
	}
	
	func deletePassword(for account: String) {
		var query: [CFString: Any] = [:]
		query[kSecClass] = kSecClassGenericPassword
		query[kSecAttrAccount] = account
		
		do {
			try deleteItem(query: query)
		} catch {
			return
		}
	}
}

@propertyWrapper
struct Credentials: DynamicProperty {
	private let label: String
	private let storage = SecureStorage()
	
	init(_ label: String) {
		self.label = label
	}
	
	var wrappedValue: SecureStorage.Credentials? {
		get { storage.getCredentials(with: label) }
		nonmutating set {
			if let newValue = newValue {
				storage.updateCredentials(newValue, with: label)
			} else {
				storage.deleteCredentials(with: label)
			}
		}
	}
}

@propertyWrapper
public struct Password: DynamicProperty {
	private let key: String
	private let storage = SecureStorage()
	
	public init(_ key: String) {
		self.key = key
	}
	
	public var wrappedValue: String? {
		get { storage.getPassword(for: key) }
		nonmutating set {
			if let newValue {
				storage.updatePassword(newValue, for: key)
			} else {
				storage.deletePassword(for: key)
			}
		}
	}
}
