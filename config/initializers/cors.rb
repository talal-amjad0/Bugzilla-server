# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin Ajax requests.

# Read more: https://github.com/cyu/rack-cors
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:5173'  # React app domain (or your actual frontend URL)
    
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :delete, :options],
      expose: ['Set-Cookie'],  # Expose the Set-Cookie header so the browser knows the cookie is set
      credentials: true  # Allow cookies to be sent with cross-origin requests
  end
end
  
