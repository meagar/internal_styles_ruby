Rails.application.routes.draw do
  mount InternalStyles::Engine => "/internal_styles"
end
