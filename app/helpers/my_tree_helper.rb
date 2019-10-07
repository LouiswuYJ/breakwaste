module MyTreeHelper
  def order_count(order_count)    
    if order_count <= 6
      image_tag "trees/tree1.jpg"
    elsif order_count > 6 && order_count <= 30
      image_tag "trees/tree2.jpg"
    else order_count >30
      image_tag "trees/tree3.jpg"
    end 
  end
end
