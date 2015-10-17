#pragma once

#include <iterator>
#include <memory>

class BiologicalSequence
{
public:

	using ptr = std::shared_ptr<BiologicalSequence>;

	// iterator types
	using iterator = std::string::iterator;
	using const_iterator = std::string::const_iterator;

	// constructors
	BiologicalSequence() = default;
	BiologicalSequence(int length) : storage(length, '-') {}
	BiologicalSequence(std::string s) : storage{ s } {}

	// destructor
	~BiologicalSequence() = default;

	// const iterators
	const_iterator cbegin() const { return storage.cbegin(); }
	const_iterator cend() const { return storage.cbegin() + storage.size(); }

	// const methods
	int length() const { return storage.length(); }
	int ungappedLength() const;
	BiologicalSequence ungapped() const;
	char operator[](unsigned int i) const { return storage[i]; }
	const std::string str() const { return storage; }

	// non-const iterators
	iterator begin() { return storage.begin(); }
	iterator end() { return storage.begin() + storage.size(); }

	// non-const methods
	BiologicalSequence& operator+=(char c) { storage += c; return *this; }
	BiologicalSequence& operator+=(std::string s) { storage += s; return *this; }
	BiologicalSequence reverse();

private:

	std::string storage;

};

std::ostream & operator<<(std::ostream& os, const BiologicalSequence& s);