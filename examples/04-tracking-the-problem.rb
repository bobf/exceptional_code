$global_storage = {
  people: []
}

def process_records(records)
  puts 'processing records'

  records.each do |record|
    name = retrieve(:name, record)
    town = retrieve(:town, record)
    if name.nil? || town.nil?
      puts 'missing fields, skipping record'
    else
      save_record(name, town)
      puts 'record saved'
    end
  end

  puts 'finished processing'
end

def retrieve(field, record)
  record.fetch(field)
rescue KeyError => e
  handle_error(field, record, e)
  nil
end

def save_record(name, town)
  $global_storage.fetch(:people).push(name: name, town: town)
end

def handle_error(field, record, e)
  source = e.backtrace.first
  puts "#{source}: Error fetching #{field} from #{record}: #{e.inspect}"
end

records = [
  { name: 'john', town: 'london' },
  { name: 'chris', twon: 'chichester' },
  { name: 'andrew', town: 'bristol' }
]

process_records(records)
