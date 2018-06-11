module ApplicationHelper

  #RETURNS A HIDDEN FIELD TAG WITH THE PARENT ID OF AN ITEM
  def id_field(item,parent)
    hidden_field_tag "#{item.class.to_s.downcase}[#{parent.class.to_s.downcase}_id]", parent.id
  end

  #CREATES A LINK TO DELETE AN ITEM, WORKS FOR ANY ITEM CREATED BY A USER
  def delete(item)
    if current_user_created_this_item?(item) || user_admin?
      link_to "Delete #{item.class.to_s}", item, method: :delete, data: {confirm: "Really?!"} ,:class => 'btn btn-danger'
    end
  end

  #CREATES A LINK TO EDIT AN ITEM, WORKS FOR ANY ITEM CREATED BY A USER
  def edit(item)
    if current_user_created_this_item?(item) || user_admin?
      #link_to "Edit #{item.class.to_s}", edit_pairing_comment_path(@pairing)
      link_to "Edit #{item.class.to_s}", "/#{item.class.to_s.downcase}s/#{item.id}/edit", :class=> "btn btn-warning"
    end
  end


  def shows_error_messages(item)
    if item.errors.any?
      content_tag(:ul, :class => 'field_with_errors') do
        item.errors.full_messages.collect do |msg|
            content_tag(:li, msg)
        end.join.html_safe
      end
    end
    #item.errors.clear
  end



end
