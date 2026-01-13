
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w(

  application_bootstrap.css
  application_bootstrap.js

  wco_email/application.css
  wco_email/application.js

  iron_warbler/application.css
  iron_warbler/application.js

  wco_hosting/application.css
  wco_hosting/application.js

  wco_models/application.css
  wco_models/application.js

);
