class SpaceAge
  MERCURY_EARTH_ORBITAL_RATIO = 0.2408467
  VENUS_EARTH_ORBITAL_RATIO = 0.61519726
  MARS_EARTH_ORBITAL_RATIO = 1.8808158
  JUPITER_EARTH_ORBITAL_RATIO = 11.862615
  SATURN_EARTH_ORBITAL_RATIO = 29.447498
  URANUS_EARTH_ORBITAL_RATIO = 84.016846
  NEPTUNE_EARTH_ORBITAL_RATIO = 164.79132

  def initialize(seconds)
    @seconds = seconds
  end

  def on_mercury
    on_earth / MERCURY_EARTH_ORBITAL_RATIO
  end

  def on_venus
    on_earth / VENUS_EARTH_ORBITAL_RATIO
  end

  def on_earth
    @seconds / 60 / 60 / 24 / 365.25
  end

  def on_mars
    on_earth / MARS_EARTH_ORBITAL_RATIO
  end

  def on_jupiter
    on_earth / JUPITER_EARTH_ORBITAL_RATIO
  end

  def on_saturn
    on_earth / SATURN_EARTH_ORBITAL_RATIO
  end

  def on_uranus
    on_earth / URANUS_EARTH_ORBITAL_RATIO
  end

  def on_neptune
    on_earth / NEPTUNE_EARTH_ORBITAL_RATIO
  end
end
