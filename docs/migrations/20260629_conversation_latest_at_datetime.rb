
collection = WcoEmail::Conversation.collection

collection.find({ latest_at: { "$type" => "string" } }).each do |doc|
  raw = doc["latest_at"]

  next if raw.nil?

  parsed =
    begin
      Time.parse(raw)
    rescue ArgumentError
      nil
    end

  next unless parsed

  collection.update_one(
    { _id: doc["_id"] },
    {
      "$set" => {
        latest_at: parsed
      }
    }
  )
end

