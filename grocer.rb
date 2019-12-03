def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  index = 0
  while collection[index] do
    if collection[index][:item] == name
      return collection[index]
    end
    index += 1
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  index = 0
  result = []
  while cart[index] do 
    exist = result.detect{|item| item[:item] == cart[index][:item]}
    if exist
      exist[:count] += 1
    else
      cart[index][:count] = 1
      result.push(cart[index])
    end
    index += 1
  end
  return result
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupon_index = 0
  while coupons[coupon_index] do 
    item = cart.find{|x| x[:item] == coupons[coupon_index][:item]}
    
    if item != nil && item[:count] >= coupons[coupon_index][:num]
      item[:count] -= coupons[coupon_index][:num]
      copy = {
        :item => item[:item] + " W/COUPON",
        :count => coupons[coupon_index][:num],
        :clearance => item[:clearance],
        :price => coupons[coupon_index][:cost] / coupons[coupon_index][:num]
      }
      cart.push(copy)
    end
    coupon_index += 1
  end
  return cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0
  while cart[index] do
    if cart[index][:clearance]
      cart[index][:price] *= 0.8 
      cart[index][:price] = cart[index][:price].round(2)
    end
    index += 1
  end
  return cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  result = consolidate_cart(cart)
  result = apply_coupons(result, coupons)
  result = apply_clearance(result)
  index = 0
  sum = 0
  while result[index] do
    sum += result[index][:price] * result[index][:count]
    index += 1
  end
  if sum > 100
    sum *= 0.9
    sum = sum.round(2)
  end
  return sum
end
