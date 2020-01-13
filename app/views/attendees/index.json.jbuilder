json.array! @attendees do |attendee|
  json.id attendee.user.id
  json.name attendee.user.name
end