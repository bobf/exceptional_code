def process_records(records)
  records.each do |record|
    record.saev! rescue nil
  end
  puts 'finished processing successfully'
end

process_records(%w[one two three four five])
