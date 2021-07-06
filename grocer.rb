def find_item_by_name_in_collection(name, collection)
  i = 0 
  while i < collection.length do 
    if collection[i][:item] == name 
      item = collection[i]
    end
    i += 1
  end  
  return item
end

def consolidate_cart(cart)
  cons_cart = []
  i = 0
  item_hash = {}
  while i < cart.length do
    if item_hash.value?(cart[i][:item])
      item_hash[:count] += 1
    elsif !item_hash.value?(cart[i][:item])
      item_hash = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1
        }
      cons_cart << item_hash
    end
    i += 1
  end
 cons_cart
end

def apply_coupons(cart, coupons)
  # REMEMBER: This method **should** update cart
  i = 0
  j = 0
  while i < cart.length do
    while j < coupons.length do 
      if cart[i][:item] == coupons[j][:item] # check if item in cart has coupon, if it does proceed
        cost_per_item = coupons[j][:cost] / coupons[j][:num] # calc how much each item costs using a coupon
        if cart[i][:count] >= coupons[j][:num] # if there is a coupon, compare the count in cart with coupon num. 
            count_after_coupons = cart[i][:count] - (coupons[j][:num]) # get the new count for the existing item
            cart[i][:count] = count_after_coupons  #update existing item count
            item_name = cart[i][:item]
            item_w_coupon = {
              :item => "#{item_name} W/COUPON", # create new item hash w coupon
              :price => cost_per_item,
              :clearance => cart[i][:clearance],
              :count => coupons[j][:num]}
            cart.push(item_w_coupon) # put item into cart
        end  
      end
      j += 1
      cost_per_item = 0
      count_per_coupon = 0
    end
    i += 1
    j = 0
  end
  return cart
end

def apply_clearance(cart)
  i = 0 
  while i < cart.length do
    if cart[i][:clearance] == true
      discounted_price = cart[i][:price] * 0.8
      rounded_price = discounted_price.round(2)
      cart[i][:price] = rounded_price
    end  
    i += 1
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
  clean_cart = consolidate_cart(cart)
  cleaner_cart = apply_coupons(clean_cart, coupons)
  cleanest_cart = apply_clearance(cleaner_cart)
  i = 0 
  final_price = 0
  while i < cleaner_cart.length do
    items_price = cleaner_cart[i][:price] * cleaner_cart[i][:count]  
    final_price += items_price
    i += 1
  end
  if final_price > 100
    final_price = final_price * 0.9
  end 
  return final_price
end
