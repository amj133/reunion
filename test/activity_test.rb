require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/activity'
require 'pry'

class ActivityTest < Minitest::Test

  def test_it_exists
    activity = Activity.new("hiking")

    assert_instance_of Activity, activity
  end

  def test_has_a_name
    activity = Activity.new("hiking")

    assert_equal "hiking", activity.name
  end

  def test_can_add_a_participant
    activity = Activity.new("skydiving")

    activity.add_participants({Bob: 165})

    assert_equal [:Bob], activity.participants.keys
    assert_equal [165], activity.participants.values
  end

  def test_can_add_multiple_participants
    activity = Activity.new("skydiving")

    activity.add_participants({Bob: 165, Alice: 215})
    activity.add_participants({Frodo: 5})

    assert_equal [:Bob, :Alice, :Frodo], activity.participants.keys
    assert_equal [165, 215, 5], activity.participants.values
  end

  def test_total_cost_returns_total_cost_of_activity
    activity = Activity.new("skydiving")

    activity.add_participants({Bob: 165, Alice: 215})
    activity.add_participants({Frodo: 5})

    assert_equal 385, activity.total_cost
  end

  def test_split_cost_returns_even_split_of_total_cost
    activity = Activity.new("skydiving")

    activity.add_participants({Bob: 115, Alice: 85})
    activity.add_participants({Frodo: 100})

    assert_equal 100, activity.split_cost
  end

  def test_amount_owed_returns_hash_with_amount_owed_positive_or_negative
    activity = Activity.new("skydiving")

    activity.add_participants({Bob: 115, Alice: 85})
    activity.add_participants({Frodo: 100})

    assert_equal [:Bob, :Alice, :Frodo], activity.amount_owed.keys
    assert_equal [-15, 15, 0], activity.amount_owed.values
  end

end
