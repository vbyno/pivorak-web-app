ActiveSupport::Notifications.subscribe('user_registered', Profiling::UserRegistrationHandler)
ActiveSupport::Notifications.subscribe('user_registered', Authentication::NewUserRegisteredHandler)
ActiveSupport::Notifications.subscribe('user_email_changed', Profiling::UserEmailChangedHandler)
