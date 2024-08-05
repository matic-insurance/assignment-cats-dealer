require Rails.root.join('lib/lib_loader.rb')

Rails.application.config.to_prepare do
  LibLoader.load
end
