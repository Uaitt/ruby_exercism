class BoutiqueInventory
  def initialize(items)
    @items = items
  end

  def item_names
    @items.map { |item| item[:name] }.sort
  end

  def cheap
    @items.select { |item| item[:price] < 30 }
  end

  def out_of_stock
    @items.select { |item| item[:quantity_by_size].empty? }
  end

  def stock_for_item(name)
    wanted_item = @items.find { |item| item[:name] == name }
    wanted_item[:quantity_by_size]
  end

  def total_stock
    @items.inject(0) do |total_stock, item|
      current_stock = item[:quantity_by_size].values.sum
      total_stock + current_stock
    end
  end
end
