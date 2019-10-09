module MyTreeHelper
  def order_count(order_count)    
    case order_count 
    when order_count == 0
      image_tag "trees/bud1.png"
    when 1..5
      image_tag "trees/bud2.png"
    when 6..10
      image_tag "trees/tree1.png"
    when 11..15
      image_tag "trees/tree2.png"
    when 16..20
      image_tag "trees/tree3.png"
    when 21..25
      image_tag "trees/tree4.png"
    else  
      image_tag "trees/tree5.png"
    end
  end
end
