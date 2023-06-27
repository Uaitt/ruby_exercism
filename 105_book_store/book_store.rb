class BookStore
  PRICE = 8
  DISCOUNTS = [0, 0, 0.05, 0.10, 0.20, 0.25].freeze

  class << self
    def calculate_price(basket)
      basket = basket.sort_by { |book| basket.count(book) }.reverse
      groups = 5.downto(1).map { |i| unique_groups_by(basket, i) }
      cheapest_group = groups.min_by { |group| price(group) }
      price(cheapest_group)
    end

    private

    def unique_groups_by(basket, max_length)
      basket.each_with_object([[]]) do |book, groups|
        book_occurrences = groups.flatten.count(book)
        groups.each { |group| group << book && break if !group.include?(book) && group.size < max_length }
        groups << [book] if groups.flatten.count(book) == book_occurrences
      end
    end

    def price(ary)
      ary.inject(0) { |total, sub_group| total + (PRICE * sub_group.length) * (1 - DISCOUNTS[sub_group.length]) }
    end
  end
end
