desc "Adds a secure key to Signatures"
task :add_secure_key_to_signatures => :environment do
  Signature.where(secure_key: nil).each do |signature|
    signature.secure_key = SecureRandom.hex(8)
    signature.save!
  end
end