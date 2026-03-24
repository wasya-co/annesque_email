
if !ENV['EMAIL'] || !ENV['PASSWORD']
  puts "+++ env vars EMAIL, PASSWORD must be specified for the seed to run."
  exit 2
end

leadset   = Wco::Leadset.find_or_create_by!( company_url: ENV['EMAIL'] )
profile   = Wco::Profile.where( email: ENV['EMAIL'] ).first
profile ||= Wco::Profile.create!( email: ENV['EMAIL'], leadset: leadset )

user = User.where({ email: ENV['EMAIL'] }).first
if user
  puts "+++ User `#{ENV['EMAIL']}` already exists."
else
  user = User.new email: ENV['EMAIL'], password: ENV['PASSWORD']
  user.save!
  print "+++ User `#{ENV['EMAIL']}` created."
end

inbox_tag = Wco::Tag.find_or_create_by!( slug: 'inbox' )

