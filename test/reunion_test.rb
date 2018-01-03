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
end
