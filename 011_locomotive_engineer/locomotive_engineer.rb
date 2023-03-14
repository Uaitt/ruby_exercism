class LocomotiveEngineer
  class << self
    def generate_list_of_wagons(*wagon_ids)
      wagon_ids
    end

    def fix_list_of_wagons(wagons_id, missing_wagons)
      wagons_id.rotate!(2)
      wagons_id.insert(1, *missing_wagons)
    end

    def add_missing_stops(route, **stops)
      route.merge(stops: stops.values)
    end

    def extend_route_information(route, more_route_information)
      { **route, **more_route_information }
    end
  end
end
