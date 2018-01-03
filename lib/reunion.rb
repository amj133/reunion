require './lib/activity'
require 'pry'

class Reunion
  attr_reader :location, :activities

  def initialize(location)
    @location = location
    @activities = []
  end

  def add_activity(activity)
    @activities << activity
  end

  def total_cost
    @activities.reduce(0) do |amount, activity|
      amount += activity.total_cost
      amount
    end
  end

  def activity_debts
    x = @activities.map do |activity|
      activity.amount_owed
    end
    binding.pry
  end

  # def people_debts
  #   until activity_debts
  # end

end
