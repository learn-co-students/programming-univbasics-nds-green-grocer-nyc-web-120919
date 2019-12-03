require 'pp'
require 'pry'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
   
i = 0 
while i < collection.length do
  if collection[i][:item] === name  
    return collection[i]
  end 
 i += 1
end  
nil 
end

def consolidate_cart(cart)
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
#binding.pry    
my_array = []
i = 0 
while i < cart.length
  my_hash = {:item => cart[i][:item], :price => cart[i][:price],:clearance => cart[i][:clearance], :count => 1}
  if my_array.include?(my_hash)
    existing_item_index = my_array.index(my_hash)
    my_array[existing_item_index][:count] += 1
    #binding.pry 
  else 
    my_array << my_hash
  end 
  i += 1 
end 
#binding.pry 
my_array
end

def apply_coupons(cart, coupons)
#binding.pry 
i = 0 
while i < coupons.length do 
  current_coupon = coupons[i]
  cart_item = find_item_by_name_in_collection(current_coupon[:item], cart)
  couponed_item_name = "#{coupons[i][:item]} W/COUPON"
  #binding.pry 
  cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
  if cart_item && cart_item[:count] + 1 >= coupons[i][:num]
    #binding.pry 
    if cart_item_with_coupon
      cart_item_with_coupon[:count] += coupons[i][:num]
      cart_item[:count] -= coupons[i][:num]
    else
      cart_item_with_coupon = {
        :item => couponed_item_name, 
        :price => coupons[i][:cost] / coupons[i][:num],
        :count => coupons[i][:num],
        :clearance => cart_item[:clearance]}
        #binding.pry 
      cart << cart_item_with_coupon
      #binding.pry 
      cart_item[:count] -= coupons[i][:num]
      #binding.pry 
    end 
  end   
  i += 1 
end 
cart 
#binding.pry 
end 

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
i = 0 
while i < cart.length do
 # binding.pry 
  discounted_price = (cart[i][:price] * 0.8).round(2)
  if cart[i][:clearance] != false 
    cart[i][:price] = discounted_price 
  end 
  i += 1
end
#binding.pry 
cart 
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
  
updated_cart = consolidate_cart(cart)
#binding.pry 
apply_coupons(updated_cart, coupons)
apply_clearance(updated_cart)
#binding.pry

i = 0 
running_total = 0 
while i < updated_cart.length do 
  running_total += (updated_cart[i][:price]*updated_cart[i][:count])
  #binding.pry
  i += 1 
  end 
if running_total > 100 
  discounted_total = running_total * 0.9 
  discounted_total 
else 
  running_total 
end 
end
