def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i = 0 
  while i < collection.size do
    if collection[i][:item] === name then
      return collection[i]
    end
    i += 1 
  end
  nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  new_cart = []
  
  i = 0 
  while i < cart.size do
    item_name = cart[i][:item]
    
    result = find_item_by_name_in_collection(item_name, new_cart)
    
    if (result) then
      result[:count] += 1 
    else
      result = cart[i]
      result[:count] = 1 
      new_cart << result
    end
    i += 1 
  end
  new_cart
end

def apply_coupons(cart, coupons)
  
  i = 0 
  while i < coupons.size do 
    item_name = coupons[i][:item] 
   
    cart_item_on_sale = find_item_by_name_in_collection(item_name, cart)
    
    if (cart_item_on_sale) then
      cart = apply_coupon(coupons[i], cart_item_on_sale, cart)
    end
    i += 1 
  end
   
  return cart
end

def apply_coupon (coupon, cart_item, cart) 
  coupon_num = coupon[:num]
  item_num = cart_item[:count]
  if (item_num >= coupon_num) then
    
    not_on_coupon = item_num % coupon_num
    on_coupon = item_num - not_on_coupon
    
    
    copy_item = cart_item.dup
    copy_item[:count] = not_on_coupon
    cart << copy_item
  
    cart_item[:item] = "#{cart_item[:item]} W/COUPON"
    cart_item[:count] = on_coupon
    per_item = coupon[:cost] / coupon_num
    cart_item[:price] = per_item
    
  end

  return cart
end



def apply_clearance(cart)
  
  i = 0 
  while i < cart.size do
    if cart[i][:clearance] then
      cart[i][:price] = (cart[i][:price] * 0.8).round(2)
    end
    i += 1
  end
  
  return cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)
  
  i = 0 
  total = 0.0
  while i < new_cart.size do
    subtotal = new_cart[i][:price] * new_cart[i][:count]
    total += subtotal
    i += 1
  end
  
  if total > 100 then 
    total = (total * 0.9).round(2)
  end
  return total
  
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
