require 'set'
require_relative "item.rb"

class SudoPriorityQueue
  attr_reader :q
  def initialize(items: nil)
    @q = Set.new(items)
  end

# insert
  def insert(item)
    q.add(item)
  end

  def bulk_insert(items)
    q.merge(items)
  end

# pull_highest
  def pull_highest
    highest = q.max
    q.delete highest
    highest
  end

# pull_lowest
  def pull_lowest
    lowest = q.min
    q.delete lowest
    lowest
  end

# find_by_priority
  def find_highest
    highest = q.max
  end

  def find_lowest
    lowest = q.min
  end

  def find_by_priority(value)
    q.find {|member| member.priority == value}
  end

# find_by_label
  def find_by_label(value)
    q.find {|member| member.label == value }
  end

# empty?
  def empty?
    q.empty?
  end

# clear
  def clear
    q.clear
  end

# update
  def update_member(member, attribute, value)
    member.send(attribute, value)
  end

  def update_member_priority(member, value)
    member.priority = value
  end
end
