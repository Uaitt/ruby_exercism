class Moviegoer
  def initialize(age, member: false)
    @age = age
    @member = member
  end

  def ticket_price
    @age >= 60 ? 10 : 15
  end

  def watch_scary_movie?
    @age >= 18
  end

  def claim_free_popcorn!
    @member ? '🍿' : raise(NotMovieClubMemberError)
  end
end

class NotMovieClubMemberError < RuntimeError
end
