require './lib/activity'
require 'pry'

class Reunion
  attr_reader :location, :activities

  def initialize(location)
    @location = location
    @activities = []
  end

  def add_activity(activity)
    activities << activity
  end

  def total_cost
    activities.reduce(0) do |amount, activity|
      amount += activity.total_cost
      amount
    end
  end

  def activity_debts
    @activities.map do |activity|
      activity.amount_owed
    end
  end

  def people_debts
    activity_debts.reduce(Hash.new(0)) do |people_debts, activity_debt|
      people_debts.merge!(activity_debt){|key, oldval, newval| oldval + newval}
      people_debts
    end
  end

  def debt_summary
    people_debts.map do |key, value|
      "#{key}: #{value}\n"
    end.join
  end

end
