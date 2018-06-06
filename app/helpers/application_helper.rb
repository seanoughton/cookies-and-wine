module ApplicationHelper
  def id_field(item,parent)
    hidden_field_tag "#{item.class.to_s.downcase}[#{parent.class.to_s.downcase}_id]", parent.id
  end
end
