# SudoPriorityQueue

## **Ruby Set Is Effectively A Priority Queue**

Ruby does not natively implement a priority queue. However, it is quite easy to implement the features of a priority queue using the Ruby class, Set.

[Documentation for Ruby Set](https://ruby-doc.org/stdlib-3.1.0/libdoc/set/rdoc/Set.html)

One can use SudoPriorityQueue as a priority queue but it is really designed to show how the features of Set and member Items that include Comparable and implement <=> match up to expected features of a priority queue. I generally use Set directly in working code.

In SudoPriorityQueue @q, a Set, provides the functionality of a priority queue, if it holds items that include the Comparable module and implement the 'spaceship' operator, <=>.



The 2 classes used:

**SudoPriorityQueue**
 - Initialize with list of items
    - @q: Set holding items retrievable on a priority attribute of the item
 - Only one instance of an item may be stored in this queue though item attributes may be changed.

**Item**
 - Includes Comparable
 - Initialize with label and priority attributes
	 - @priority can be given an initial default value and has getter and setter methods
	 - @label has only a getter method
 - Implements <=> method to compare instances by priority

This exercise was triggered by statements I have frequently seen in Advent of Code that Ruby does not provide a Priority Queue
