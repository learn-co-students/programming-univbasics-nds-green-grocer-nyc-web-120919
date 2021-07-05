def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs

  index = 0
  while index < collection.length do
    matches = collection[index]
    if matches[:item] == name
       return matches
    end
  index += 1
  end
   nil
end
#----------------method to add items
def increment_item_count(cart, item_name)
  index = 0
  while index < cart.length do
    current_item = cart[index]
    if ( current_item[:item] == item_name )
      current_item[:count] += 1
    end
    index += 1
  end
  cart
end


def consolidate_cart(cart)
  #p "original cart:"
 # p cart
  updated_result =[]
  index = 0
    while index < cart.length do
      item = cart[index]
      if (find_item_by_name_in_collection(item[:item], updated_result) == nil )
        item[:count]=1
        updated_result << item
      else increment_item_count(updated_result,item[:item])
      end
      index+=1
    end
#  p "consolidated cart:"
   updated_result
  
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
end

#---------------------------------------------

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
    #p coupons
    #p cart
    coupons_index = 0
  
   
   while coupons_index < coupons.size do
    current_coupon = coupons[coupons_index]
  
    applicable_for_discount = find_item_by_name_in_collection( current_coupon[:item], cart )
      if ( applicable_for_discount[:count] / current_coupon[:num] >= 1 )
        cart.push( {:item => "#{applicable_for_discount[:item]} W/COUPON",
                    :price => (current_coupon[:cost] / current_coupon[:num]).round(2),
                    :clearance => applicable_for_discount[:clearance],
                    :count => applicable_for_discount[:count] - ( applicable_for_discount[:count] % current_coupon[:num])})

        applicable_for_discount[:count] -= current_coupon[:num]
      end
    coupons_index += 1
  end
 #p "updated:"
  cart
end	

#---------------------------------------------

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart_index = 0
  result =[]
   
  while cart_index < cart.size do
    current_item = cart[cart_index]
      if ( current_item[:clearance] )
        current_item[:price] -= (current_item[:price])*0.20
      end
    result << current_item
    cart_index += 1
  end
  result
end

#---------------------------------------------

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
  total = 0.0
  checkout = consolidate_cart(cart)
  checkout = apply_coupons(checkout,coupons)
  checkout = apply_clearance(checkout)
  index = 0
    while index < checkout.length do
      current_item_total = (checkout[index][:price]*checkout[index][:count]).round(2)
      total += current_item_total
      index +=1
    end
    if (total > 100)
      total *=0.90
    end
     total
end
