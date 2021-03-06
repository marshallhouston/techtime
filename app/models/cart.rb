class Cart
  attr_reader :contents

  def initialize(cart_info)
    @contents = cart_info || {}
  end

  def total_count
    contents.values.sum
  end

  def count_of(id)
    contents[id.to_s] || 0
  end

  def add_freelancer(id)
    contents[id.to_s] = (contents[id.to_s] || 0) + 1
  end

  def delete_freelancer(id)
    contents[id.to_s] = 0
    contents.delete(id.to_s)
  end

  def decrease_freelancer(id)
    contents[id.to_s] = contents[id.to_s] - 1
    delete_freelancer(id) if contents[id.to_s] == 0
  end

  def freelancer_ids
    contents.keys
  end

  def collect_freelancers
    Freelancer.where(id: freelancer_ids)
  end

  def subtotal(freelancer)
    count_of(freelancer.id) * freelancer.price
  end

  def total_price
    collect_freelancers.reduce(0) do |sum, freelancer|
      sum + (freelancer.price * count_of(freelancer.id))
    end
  end
end
