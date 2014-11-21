class TagController < AdminController
  
  def index
    
    @style = Style.find(params[:style])
    
    @patterns = Pattern.all
    

    
    
  
    
  end
  

  def create
  
    @pattern_ids = params[:pattern_ids] || []
    puts @pattern_ids
    
    @style = Style.find(params[:style])
    
    @patterns = Pattern.all
    
    patterns_to_add_style, patterns_to_remove_style = @patterns.partition{ |pattern| 
      @pattern_ids.include?("#{pattern.id}")
    }
    
    patterns_to_add_style.each do | pattern |
        puts "to add"
        puts pattern.id
        PatternStyle.where(:pattern_id => pattern.id, :style_id => @style.id).first_or_create
    end
    
    puts "***********"
    puts patterns_to_remove_style
    
    patterns_to_remove_style.each do | pattern|
      puts "to delete"
      puts pattern.id
      pattern_style = PatternStyle.where(:pattern_id => pattern.id, :style_id => @style.id)
      style_id = @style.id
      puts pattern_style
      if pattern_style
        sql = "DELETE FROM patterns_styles where pattern_id = #{pattern.id} AND style_id = #{style_id}"
        ActiveRecord::Base.connection.execute(sql)
      end
    end
    
    redirect_to tag_index_path(:style => params[:style])
  
  
  end
  
    
  

end
