ActionController::Routing::Routes.draw do |map|
  map.connect '',    :controller => "game", :action => "index"
  map.connect ':id', :controller => "game", :action => "index", :id => @id
  map.connect ':controller/:action/:id'
end
