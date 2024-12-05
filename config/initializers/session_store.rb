Rails.application.config.session_store :cookie_store, 
                                       key: '_your_app_session', 
                                       same_site: :none,      # Set SameSite to None for cross-origin requests
                                       secure: Rails.env.production?, # Ensure the cookie is sent only over HTTPS in production
                                       expire_after: 1.year,
                                       max_age: 86400

