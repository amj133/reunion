
class Activity
  attr_reader :name, :participants

  def initialize(name)
    @name = name
    @participants = {}
  end

  def add_participants(people)
    participants.update(people)
  end

  def total_cost
    participants.values.sum
  end

  def split_cost
    total_cost.to_f / participants.count
  end

  def amount_owed
    participants.map do |person|
      
  end

end
