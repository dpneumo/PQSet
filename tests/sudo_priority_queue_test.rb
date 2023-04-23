# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/sudo_priority_queue'

class SudoPriorityQueueTest < Minitest::Test
  def setup
    items = [
      Item.new(label: 'b', priority: 2),
      Item.new(label: 'x', priority: 6),
      Item.new(label: 'y', priority: 6),
      Item.new(label: 'z', priority: 3),
      Item.new(label: 'w', priority: 3),
      Item.new(label: 'r', priority: 10)
    ]
    @pq = SudoPriorityQueue.new(items: items)
  end

  def test_inits_q_to_empty_if_items_not_provided
    assert_empty SudoPriorityQueue.new.q
  end

  def test_empty_returns_true_at_startup_if_items_not_provided
    assert SudoPriorityQueue.new.empty?
  end

  def test_empty_returns_false_when_the_queue_contains_items
    refute @pq.empty?
  end

  def test_correctly_pulls_highest_items_returning_nil_when_empty
    assert_equal 'r', @pq.pull_highest.label
    assert_equal 'x', @pq.pull_highest.label
    assert_equal 'y', @pq.pull_highest.label
    assert_equal 'z', @pq.pull_highest.label
    assert_equal 'w', @pq.pull_highest.label
    assert_equal 'b', @pq.pull_highest.label
    assert_nil    @pq.pull_highest
    assert @pq.empty?
  end

  def test_correctly_pulls_lowest_items_returning_nil_when_empty
    assert_equal 'b', @pq.pull_lowest.label
    assert_equal 'z', @pq.pull_lowest.label
    assert_equal 'w', @pq.pull_lowest.label
    assert_equal 'x', @pq.pull_lowest.label
    assert_equal 'y', @pq.pull_lowest.label
    assert_equal 'r', @pq.pull_lowest.label
    assert_nil    @pq.pull_lowest
    assert @pq.empty?
  end

  def test_can_mix_pull_highest_and_pull_lowest
    assert_equal 'r', @pq.pull_highest.label
    assert_equal 'b', @pq.pull_lowest.label
    assert_equal 'x', @pq.pull_highest.label
    assert_equal 'z', @pq.pull_lowest.label
    assert_equal 'y', @pq.pull_highest.label
    assert_equal 'w', @pq.pull_lowest.label
    assert_nil    @pq.pull_highest
  end

  def test_find_highest_returns_nil_for_empty_queue
    assert_nil SudoPriorityQueue.new.find_highest
  end

  def test_find_highest_returns_the_first_inserted_highest_priority_item
    assert_equal 'r', @pq.find_highest.label
    @pq.pull_highest
    assert_equal 'x', @pq.find_highest.label
  end

  def test_find_lowest_returns_nil_for_empty_queue
    assert_nil SudoPriorityQueue.new.find_lowest
  end

  def test_find_lowest_returns_the_first_inserted_lowest_priority_item
    assert_equal 'b', @pq.find_lowest.label
    @pq.pull_lowest
    assert_equal 'z', @pq.find_lowest.label
  end

  def test_find_by_priority_returns_first_inserted_with_that_priority
    assert_equal "z", @pq.find_by_priority(3).label
  end

  def test_find_by_priority_returns_nil_if_item_not_found
    assert_nil @pq.find_by_priority(4)
  end

  def test_find_by_label_returns_first_inserted_item_with_label
    assert_equal "z", @pq.find_by_label('z').label
  end

  def test_find_by_label_returns_nil_if_label_not_found
    assert_nil @pq.find_by_label('a')
  end

  def test_can_modify_priority_of_an_item_without_effecting_position_in_queue_of_other_items
    @pq.find_by_label('z').priority = 4
    assert_equal 'z', @pq.find_by_priority(4).label
    @pq.pull_lowest
    assert_equal 'w', @pq.find_lowest.label
  end

  def test_clear_empties_the_priority_queue
    @pq.clear
    assert @pq.empty?
    assert @pq.q.empty?
  end

  def test_retrieval_order_of_items_with_same_priority_is_FIFO_on_item_insertion_order
    items = ('a'..'c').to_a.map {|ch| Item.new(label: ch, priority: ch.ord-97) }
    pq = SudoPriorityQueue.new(items: items)
    items.last.priority = 1
    items.first.priority = 1
    assert_equal 'a', pq.find_highest.label
    assert_equal 'a', pq.find_lowest.label
    # Now insert in reverse order and re-test
    items = ('a'..'c').to_a.map {|ch| Item.new(label: ch, priority: ch.ord-97) }.reverse
    pq = SudoPriorityQueue.new(items: items)
    items.last.priority = 1
    items.first.priority = 1
    assert_equal 'c', pq.find_highest.label
    assert_equal 'c', pq.find_lowest.label
  end

  def test_changing_item_priorities_is_honored
    items = ('a'..'z').to_a.map {|ch| Item.new(label: ch, priority: ch.ord) }
    pq = SudoPriorityQueue.new(items: items)
    shuffled_priorities = (97..122).to_a.shuffle
    shuffle_item_priorities(items, shuffled_priorities)
      .map {|itm, _| itm }
      .sort
      .map {|itm| itm.label }
      .each {|label| assert_equal label, pq.pull_lowest.label }
  end

  def shuffle_item_priorities(items, shuffled_priorities)
    shuffled = items.zip(shuffled_priorities)
    shuffled.each {|item, new_priority| item.priority = new_priority }
  end
end
