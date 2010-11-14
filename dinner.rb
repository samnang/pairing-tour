=begin

Problem: Your user needs to decide what to make for dinner and they can purchase one additional item from the store. Given the follow options, you need them to tell you what 2 ingredients they have in their kitchen so that you know what to buy to make dinner.

For instance, if you hamburger and pasta, you need to tell them to purchase spaghetti sauce to complete that combination for dinner, which is spaghetti bolognese.

For the purposes of this exercise we need to pretend that bread and breadcrumbs are the same ingredient.

hamburger-pasta-spaghetti_sauce (spaghetti bolognese)
eggs-bacon-bread[crumbs] (bacon & eggs with toast)
chicken-ham-cheese (chicken cordon bleu)
hamburger-breadcrumbs-eggs (hamburger patties)
pasta-cheese-breadcrumbs (macaroni & cheese)
chicken-pasta-spaghetti_sauce (chicken cacciatore)
eggs-cheese-breadcrumbs (spoon bread)
ham-bacon-hamburger (heart attack waiting to happen)

List the nine different ingredients and ask the user to input 2 separate ingredients. Based upon their input, tell them what additional ingredient they need to purchase for dinner and tell them the name of the combination that they can make.

=end

class Dinner
  Ingredients = {
    :a => "hamburger",
    :b => "pasta",
    :c => "spaghetti_sauce",
    :d => "eggs",
    :e => "bacon",
    :f => "bread[crumbs]",
    :g => "chicken",
    :h => "ham",
    :i => "cheese"
  }

  Foods = {
    "spaghetti bolognese" => [:a, :b, :c],
    "bacon & eggs with toast" => [:d, :e, :f],
    "chicken cordon bleu" => [:g, :h, :i],
    "hamburger patties" => [:a, :f, :d],
    "macaroni & cheese" => [:b, :i, :f],
    "chicken cacciatore" => [:g, :b, :c],
    "spoon bread" => [:d, :i, :f],
    "heart attack waiting to happen" => [:h, :e, :a]
  }

  def initialize(ingredients)
      @ingredients_in_kitchen = ingredients
      @available_options=[]
  end

  def show_available_options
    Foods.each do |food, combination|
       additional_ingredient = combination - @ingredients_in_kitchen
       
       if additional_ingredient.size == 1
         @available_options << [Ingredients[additional_ingredient.first], food] 
       end         
    end
    
    @available_options
  end

  def select(option)
    dinner = @available_options[option - 1]
    
    puts "You have to buy an additional #{dinner[0]} to make your #{dinner[1]}"
  end
end

dinner = Dinner.new [:a, :b]
dinner.show_available_options
dinner.select(1)
