module ApplicationHelper
	def login_helper style = ''
 	  if current_user.is_a?(GuestUser)
      (link_to "Register", new_user_registration_path, class: style) + " ".html_safe +
      (link_to "Login", new_user_session_path, class: style)
  	else
      if logged_in?(:admin)
        (link_to "Admin", admin_root_path, class: style, target: "_blank") + " ".html_safe +
        (link_to "Document", document_path, class: style) + " ".html_safe +
        (link_to "Edit Account", edit_user_registration_path, class: style) + " ".html_safe +
    	  (link_to "Logout", destroy_user_session_path, method: :delete, class: style)
      elsif logged_in?(:truck)
        (link_to "Document", document_path, class: style) + " ".html_safe +
        (link_to "Edit Account", edit_user_registration_path, class: style) + " ".html_safe +
        (link_to "Logout", destroy_user_session_path, method: :delete, class: style)
      else
        (link_to "Edit Account", edit_user_registration_path, class: style) + " ".html_safe +
        (link_to "Logout", destroy_user_session_path, method: :delete, class: style)
      end
  	end
	end

  def nav_items
    [
      {
        url: root_path,
        title: 'Home'
      },
      {
        url: trucks_path,
        title: 'Trucks'
      },
      {
        url: our_company_path,
        title: 'Our Company'
      },
    ]
  end

  def nav_helper style, tag_type
    nav_links = ''

    nav_items.each do |item|
      nav_links << "<#{tag_type}><a href='#{item[:url]}' class='#{style} #{active? item[:url]}'>#{item[:title]}</a></#{tag_type}>"
    end

    nav_links.html_safe
  end
	
	def active? path
    "active" if current_page? path
  end

  def alerts_helper
    alert = (flash[:alert] || flash[:error] || flash[:notice])

    if alert
      alert_generater alert
    end
  end

  def alert_generater msg
    js add_gritter(msg, title: "UFTA Notification", sticky: false), extend_gritter(:position => :top_left)
  end

  def place_holder_img img, type
    case type 
      when 'main' 
        if img.model.main_image?
          img
        else
          'healthy-recipes.jpg'
        end
      when 'thumb' 
        if img.model.thumb_image?
          img
        else
          'lunch-truck-it-favicon.jpg'
        end
      when 'menu' 
        if img.model.food_image?
          img
        else
          # 'eat-circle-orange.png'
          # 'black-spoon-and-fork.jpg'
          'fork-knife-plate.png'
        end
    end
  end

  def copyright_generator
    JohnsonCopyRight::Renderer.copyright 'Utah Food Truck Association', 'All rights reserved'
  end
end
