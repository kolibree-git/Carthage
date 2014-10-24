//
//  GitHub.swift
//  Carthage
//
//  Created by Justin Spahr-Summers on 2014-10-10.
//  Copyright (c) 2014 Carthage. All rights reserved.
//

import Foundation
import LlamaKit

/// Describes a GitHub.com repository.
public struct Repository: Equatable {
	public let owner: String
	public let name: String

	/// Parses repository information out of a string of the form "owner/name".
	static func fromNWO(NWO: String) -> Result<Repository> {
		let components = split(NWO, { $0 == "/" }, maxSplit: 1, allowEmptySlices: false)
		if components.count < 2 {
			return failure()
		}

		return success(self(owner: components[0], name: components[1]))
	}
}

public func ==(lhs: Repository, rhs: Repository) -> Bool {
	return lhs.owner == rhs.owner && lhs.name == rhs.name
}

extension Repository: JSONDecodable {
	public static func fromJSON(JSON: AnyObject) -> Result<Repository> {
		if let NWO = JSON as? String {
			let components = split(NWO, { $0 == "/" }, maxSplit: 1, allowEmptySlices: false)
			if components.count < 2 {
				return failure()
			}

			return success(self(owner: components[0], name: components[1]))
		} else {
			return failure()
		}
	}
}

extension Repository: Printable {
	public var description: String {
		return "\(owner)/\(name)"
	}
}
