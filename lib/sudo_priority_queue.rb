require 'set'
require_relative "item.rb"

class SudoPriorityQueue
  atte_reader :q
  def initialize(items:)
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
    qs = q.max
    q.delete qs
    qs
  end

# pull_lowest
  def q_shortest
    qs = q.min
    q.delete qs
    qs
  end

# find_by_priority
  def find_lowest
    qs = q.min
  end

  def find_highest
    qs = q.max
  end

  def find_by_priority(value)
    q.find {|member| member.priority == value}

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
