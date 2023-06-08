# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/pq_set'
require_relative '../lib/item'

class PQSetTest < Minitest::Test
  def setup
    @pq = PQSet.new
    @pq.insert(Item.new(label: 'b', priority: 2))
    @pq.insert(Item.new(label: 'x', priority: 6))
    @pq.insert(Item.new(label: 'y', priority: 6))
    @pq.insert(Item.new(label: 'z', priority: 3))
    @pq.insert(Item.new(label: 'w', priority: 3))
    @pq.insert(Item.new(label: 'r', priority: 10))
  end

  def test_an_alias_for_insert # <<
    @pq << Item.new(label: 'm', priority: 20)
    assert_equal 'm', @pq.pull_highest.label
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

  def test_find_highest_returns_nil_for_empty_queue
    assert_nil PQSet.new.find_highest
  end

  def test_find_highest_returns_the_first_inserted_highest_priority_item
    assert_equal 'r', @pq.find_highest.label
    @pq.pull_highest
    assert_equal 'x', @pq.find_highest.label
  end

  def test_identifies_empty_queue
    pq = PQSet.new
    assert pq.empty?
    pq.insert(Item.new(label:'T', priority: 5))
    refute pq.empty?
    pq.pull_highest
    assert pq.empty?
  end

  def test_clear_empties_the_priority_queue
    @pq.clear
    assert @pq.empty?
  end

  def test_returns_correct_queue_size
    assert_equal 6, @pq.size
    @pq.pull_highest
    assert_equal 5, @pq.size
  end

# Extensions tests
  def test_returns_string_representation_of_queue
    expect = [["b", 2], ["x", 6], ["y", 6], ["z", 3], ["w", 3], ["r", 10]]
    assert_equal expect, @pq.to_s
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

  def test_find_lowest_returns_nil_for_empty_queue
    assert_nil PQSet.new.find_lowest
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

# Implementation tests
  def test_can_modify_an_item_priority_sin_position_delta_in_queue_of_other_items
    @pq.find_by_label('z').priority = 4
    assert_equal 'z', @pq.find_by_priority(4).label
    @pq.pull_lowest
    assert_equal 'w', @pq.find_lowest.label
  end

  def test_retrieval_order_of_items_with_same_priority_is_FIFO_on_item_insertion_order
    pq = PQSet.new
    items = ('a'..'c').to_a
      .map {|ch| Item.new(label: ch, priority: ch.ord-97) }
      .each {|item| pq.insert(item) }
    items.last.priority = 1
    items.first.priority = 1
    assert_equal 'a', pq.find_highest.label
    assert_equal 'a', pq.find_lowest.label
    # Now insert in reverse order and re-test
    pq = PQSet.new
    items = ('a'..'c').to_a
      .map {|ch| Item.new(label: ch, priority: ch.ord-97) }
      .reverse
      .each {|item| pq.insert(item) }
    items.last.priority = 1
    items.first.priority = 1
    assert_equal 'c', pq.find_highest.label
    assert_equal 'c', pq.find_lowest.label
  end

  def test_changing_item_priorities_is_honored
    pq = PQSet.new
    items = ('a'..'z').to_a
      .map {|ch| Item.new(label: ch, priority: ch.ord) }
      .each {|item| pq.insert(item) }
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
