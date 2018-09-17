$global_storage = {
  people: []
}

def process_records(records)
  begin
    puts 'processing records'
    records.each do |record|
      name = record.fetch(:name)
      town = record.fetch(:town)
      save_record(name, town)
    end
  rescue KeyError
    puts 'missing fields, skipping record'
  end

  puts 'finished processing'
end

def save_record(name, town)
  $global_storage.fetch(:poeple).push(name: name, town: town)
end

records = [
  { name: 'john', town: 'london' },
  { name: 'chris', town: 'chichester' },
  { name: 'andrew', town: 'bristol' }
]

process_records(records)
