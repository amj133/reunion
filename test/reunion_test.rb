require 'minitest'
require 'minitest/test'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/reunion'

class ReunionTest < Minitest::Test

  def test_it_exists
    reunion = Reunion.new("Richmond")

    assert_instance_of Reunion, reunion
  end

  def test_has_location
    reunion = Reunion.new("Richmond")

    assert_equal "Richmond", reunion.location
  end

  def test_can_add_an_activity
    reunion = Reunion.new("Richmond")
    skydiving = Activity.new("Skydiving")

    reunion.add_activity(skydiving)

    assert_equal [skydiving], reunion.activities
  end

  def test_can_add_multiple_activities
    reunion = Reunion.new("Richmond")
    skydiving = Activity.new("Skydiving")
    backpacking = Activity.new("Backpacking")

    reunion.add_activity(skydiving)
    reunion.add_activity(backpacking)

    assert_equal [skydiving, backpacking], reunion.activities
  end

  def test_total_cost_returns_total_cost_of_all_activities
    reunion = Reunion.new("Richmond")
    skydiving = Activity.new("Skydiving")
    backpacking = Activity.new("Backpacking")

    skydiving.add_participants({Bob: 105, Alice: 215})
    backpacking.add_participants({Bob: 45, Alice: 50, Jim: 80})
    reunion.add_activity(skydiving)
    reunion.add_activity(backpacking)

    assert_equal 495, reunion.total_cost
  end

  def test_activity_debts_returns_total_debt_or_credit_for_each_person_for_each_activity
    reunion = Reunion.new("Richmond")
    skydiving = Activity.new("Skydiving")
    backpacking = Activity.new("Backpacking")

    skydiving.add_participants({Bob: 105, Alice: 215, Jim: 130})
    backpacking.add_participants({Bob: 45, Alice: 50, Jim: 25})
    reunion.add_activity(skydiving)
    reunion.add_activity(backpacking)

    assert_equal [{Bob: 45, Alice: -65, Jim: 20},
                  {Bob: -5, Alice: -10, Jim: 15}], reunion.activity_debts
  end

  def test_people_debts_returns_total_debt_or_credit_for_each_person
    reunion = Reunion.new("Richmond")
    skydiving = Activity.new("Skydiving")
    backpacking = Activity.new("Backpacking")

    skydiving.add_participants({Bob: 105, Alice: 215, Jim: 130})
    backpacking.add_participants({Bob: 45, Alice: 50, Jim: 25})
    reunion.add_activity(skydiving)
    reunion.add_activity(backpacking)
    reunion.activity_debts

    assert_equal [:Bob, :Alice, :Jim], reunion.people_debts.keys
    assert_equal [40.0, -75.0, 35.0], reunion.people_debts.values
  end

  def test_debt_summary_works
    reunion = Reunion.new("Richmond")
    skydiving = Activity.new("Skydiving")
    backpacking = Activity.new("Backpacking")

    skydiving.add_participants({Bob: 105, Alice: 215, Jim: 130})
    backpacking.add_participants({Bob: 45, Alice: 50, Jim: 25})
    reunion.add_activity(skydiving)
    reunion.add_activity(backpacking)
    puts "\nDebt Summary (person: debt(pos) or credit(neg))"
    puts "-----------------------------------------------"
    puts reunion.debt_summary

    assert_equal "Bob: 40.0\nAlice: -75.0\nJim: 35.0\n", reunion.debt_summary
  end

end
