class FipsTzs < Netzke::Basepack::Grid
include Netzke::Basepack::ActionColumn
  def configure(c)
    super
    c.model = 'FipsTz'
    c.column = [
      {name: :id},
      {name: :tz_n},
      {name: :doc},
      {name: :org},
      {name: :country},
      {name: :date_start},
      {name: :date_end}
    ]
  end
end
