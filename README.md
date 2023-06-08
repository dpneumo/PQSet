# PQSet

## **Ruby Set Is Effectively A Priority Queue**

Ruby does not natively implement a priority queue. However, it is quite easy to implement the features of a priority queue using the Ruby class, Set.

[Documentation for Ruby Set](https://ruby-doc.org/stdlib-3.1.0/libdoc/set/rdoc/Set.html)

One can use PQSet as a priority queue but it is really designed to show how the features of Set and member Items that include Comparable and implement <=> match up to expected features of a priority queue. I generally use Set directly in working code.

In PQSet @q, a Set, provides the functionality of a priority queue, if it holds items that include the Comparable module and implement the 'spaceship' operator, <=>.



The 2 classes used:

**PQSet**
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


:~/Projects/PQSet$ ruby tests/pq_benchmark.rb
max_lbl: zzzz
SampleSize: 100
Items size: 475254
                           user     system      total        real
find_highest           3.917919   1.051026   4.968945 (  5.087441)
find_lowest            3.838232   1.053790   4.892022 (  4.995369)
find_by_label - a      0.000087   0.000028   0.000115 (  0.000108)
find_by_label - mmmm   1.452687   0.408926   1.861613 (  1.932283)
find_by_label - zzzz   2.846300   0.773248   3.619548 (  3.697069)
pull_highest           4.103915   1.059642   5.163557 (  5.289190)
pull_lowest            3.598484   1.062500   4.660984 (  4.767649)

~/Projects/PriorityQueue/tests$ ruby pq_benchmark.rb
max_lbl: zzzz
SampleSize: 100
Items size: 475254


                           user     system      total        real
find_highest           0.000022   0.000006   0.000028 (  0.000025)
find_lowest            0.000025   0.000007   0.000032 (  0.000027)
find_by_label - a     19.084128   5.269911  24.354039 ( 24.724780)
find_by_label - mmmm  19.189251   5.445657  24.634908 ( 24.977109)
find_by_label - zzzz  19.418049   5.024876  24.442925 ( 24.786161)
pull_highest           0.814849   0.207569   1.022418 (  1.066532)
pull_lowest            0.486992   0.104191   0.591183 (  0.627535)
