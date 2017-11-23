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
    js add_gritter(msg, title: "UFTA", sticky: false)
  end
end
