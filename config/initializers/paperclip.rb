Paperclip.interpolates :event do |attachment, style|
  attachment.instance.event_id || 'no_event'
end
