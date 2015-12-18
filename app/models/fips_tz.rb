class FipsTz < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 50
#  def self.search(search)
#    if search
#      where('doc LIKE ?',"%#{search}%")
#    else
#      all
#    end
#  end

  def self.search_tzn(search_tzn)
    if search_tzn
      where('tz_n = ?',"#{search_tzn}")
    else
      all
    end
  end

  def self.search_datefinish(search_datefinish)
    if search_datefinish
      where('date_end = ?',"#{search_datefinish}")
    else
      all
    end
  end
end
