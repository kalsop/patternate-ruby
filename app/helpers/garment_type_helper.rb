module GarmentTypeHelper
  

  
  def garment_type

    return self.order('id DESC')
    render :partial => "/partials/garment_types.html.erb" 
  end
  
end
