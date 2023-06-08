require 'set'
require_relative "item.rb"

# Uses Ruby's Set class + items that
# are comparable by priority to implement a priority_queue
# Set enforces uniqueness of items.

class PQSet
  attr_reader :q

  def initialize
    @q = Set.new
  end

  def insert(item)
    @q.add(item)
  end
  alias_method :<<, :insert

  #NOTE: The pull_highest order for items of equal priority is FIFO
  def pull_highest
    highest = @q.max
    @q.delete highest
    highest
  end

  #NOTE: Returns FIRST item inserted at HIGHEST Priority - FIFO
  def find_highest
    @q.max
  end

  def empty?
    @q.empty?
  end

  def size
    @q.size
  end

  def clear
    @q.clear
  end

# Extensions
  #NOTE: Deletes from Queue and returns FIRST item inserted at LOWEST Priority - FIFO
  def pull_lowest
    lowest = @q.min
    @q.delete lowest
    lowest
  end

  #NOTE: Returns FIRST item inserted at LOWEST Priority - FIFO
  def find_lowest
    @q.min
  end

  def to_s
    @q.map {|e| [e.label, e.priority] }
  end

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
