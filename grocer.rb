def find_item_by_name_in_collection(name, collection)
  hash = {}
  index = 0 
  while index < collection.length do 
    if name == collection[index][:item]
      hash = collection[index]
      return hash
    end 
     index += 1 
    end 
  if hash = {}
    return nil 
  else 
    return hash 
  end 
end

def consolidate_cart(cart)
 con_cart = []
  index = 0
  temp_cart = {}
  names_list = []
  while index < cart.length do 
    name = cart[index][:item]
    hash = cart[index]
    if !temp_cart[name]
      temp_cart[name] = hash
      temp_cart[name][:count] = 1 
      names_list << name
    else
      temp_cart[name][:count] += 1
    end
    index += 1 
  end
  
  index = 0 
  while index < names_list.length do
    con_cart_item = temp_cart[names_list[index]]
    con_cart << con_cart_item
    index += 1 
  end
  con_cart
end 


def apply_coupons(cart, coupons)
  index1 = 0
  cart_with_coupons = cart
  while index1 < cart.length do 
    index2 = 0 
      while index2 < coupons.length do
        if cart[index1][:item] == coupons[index2][:item]
         while cart[index1][:count] >= coupons[index2][:num] do
           cart[index1][:count] -= coupons[index2][:num]
           cart_with_coupons.push({:item => ""+ cart[index1][:item] + " W/COUPON",
            :price => coupons[index2][:cost]/coupons[index2][:num],
            :clearance => cart[index1][:clearance],
            :count => coupons[index2][:num]
           })
          end
        end
        index2 += 1 
      end
    index1 += 1 
  end
  cart_with_coupons
end

def apply_clearance(cart)
 index = 0 
  clearance_cart = cart
  while index < cart.length do
    if cart[index][:clearance] == true
      clearance_cart[index][:price] = cart[index][:price] - cart[index][:price] * 0.2
      clearance_cart[index][:price].round(2)
    end
     index += 1
  end
  clearance_cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  consolidated_coupons_cart = apply_coupons(consolidated_cart, coupons)
  consolidated_coupons_clearance_cart = apply_clearance(consolidated_coupons_cart)

  total = 0
  index = 0
  while index < consolidated_coupons_clearance_cart.length do 
    total += consolidated_coupons_clearance_cart[index][:price] * consolidated_coupons_clearance_cart[index][:count]
    index += 1 
  end

  if total >= 100 
    total = total - total * 0.1
    total.round(2)
  end

  total
end