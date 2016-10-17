class Ride < ActiveRecord::Base
  belongs_to :attraction
  belongs_to :user

  def take_ride
    if meet_requirements?
      start_ride
    elsif tall_enough && !enough_tickets # If user has less tickets than the attraction requires
      "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    elsif enough_tickets && !tall_enough
      "Sorry. You are not tall enough to ride the #{attraction.name}."
    else
      "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}." 
    end
  end

  def meet_requirements?
    enough_tickets && tall_enough
  end

  def enough_tickets
    user.tickets >= attraction.tickets
  end

  def tall_enough
    user.height >= attraction.min_height
  end

  def start_ride
    user.update(
      :happiness => (user.happiness + attraction.happiness_rating),
      :nausea => (user.nausea + attraction.nausea_rating),
      :tickets => (user.tickets - attraction.tickets)
    )

    "Thanks for riding the #{attraction.name}!"
  end

end
