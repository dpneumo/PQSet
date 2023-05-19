require 'set'
require_relative "item.rb"

# Uses Ruby's Set class + items that
# are comparable by priority to
# implement a priority_queue
# Set enforces uniqueness of items.

class SudoPriorityQueue
  attr_reader :q
  def initialize
    @q = Set.new
  end

  def insert(item)
    @q.add(item)
  end
  alias_method :<<, :insert

  def pull_highest
    highest = @q.max
    @q.delete highest
    highest
  end

  def pull_lowest
    lowest = @q.min
    @q.delete lowest
    lowest
  end

  def find_highest
    @q.max
  end

  def find_lowest
    @q.min
  end

  def empty?
    @q.empty?
  end

  def clear
    @q.clear
  end

# Extensions
  def find_by_priority(value)
    @q.find {|member| member.priority == value}
  end

  def find_by_label(value)
    @q.find {|member| member.label == value }
  end

  def bulk_insert(items)
    @q.merge(items)
  end

  def update_member(member, attribute, value)
    member.send(attribute, value)
  end

  def update_member_priority(member, value)
    member.priority = value
  end
end
